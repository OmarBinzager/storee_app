import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../features/customers/domain/entities/customer.dart';
import '../../features/orders/domain/entities/customer_order.dart';
import '../money/money.dart';

class WhatsAppService {
  const WhatsAppService();

  /// Clean phone number for WhatsApp wa.me links
  /// Handles Yemen (967), Saudi Arabia (966), and local numbers
  static String cleanPhoneNumber(String phone) {
    var cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.startsWith('00')) {
      cleaned = cleaned.substring(2);
    }
    // If local Yemeni 9-digit number starting with 7
    if (cleaned.length == 9 && cleaned.startsWith('7')) {
      cleaned = '967$cleaned';
    } else if (cleaned.length == 10 && cleaned.startsWith('05')) {
      // Local Saudi number
      cleaned = '966${cleaned.substring(1)}';
    }
    return cleaned;
  }

  /// Generates aesthetic WhatsApp invoice message
  static String formatOrderInvoice({
    required CustomerOrder order,
    String? storeName,
    String? footerMessage,
  }) {
    final store = storeName ?? 'ستوري بوتيك';
    final footer = footerMessage ?? 'شكراً لثقتكِ وتعاملكِ الراقي معنا ✨';
    final buffer = StringBuffer();

    buffer.writeln('🌸 *$store* 🌸');
    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln('📋 *فاتورة طلبية:* ${order.orderNumber}');
    buffer.writeln('👤 *العميلة العزيزة:* ${order.customerName}');
    buffer.writeln('📅 *التاريخ:* ${_formatDate(order.createdAt)}');
    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln('*تفاصيل المنتجات:*');

    for (final item in order.items) {
      final specParts = <String>[];
      if (item.color != null && item.color!.isNotEmpty) specParts.add(item.color!);
      if (item.size != null && item.size!.isNotEmpty) specParts.add(item.size!);
      final specs = specParts.isNotEmpty ? ' (${specParts.join(" / ")})' : '';

      buffer.writeln('• ${item.title}$specs');
      buffer.writeln('  الكمية: ${item.quantity} × ${item.saleUnitPrice.format()} = ${item.totalSalePrice.format()}');
    }

    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln('💰 *الإجمالي:* ${order.totalAmount.format()}');
    buffer.writeln('💳 *المدفوع:* ${order.paidAmount.format()}');

    if (order.remainingAmount.isZero) {
      buffer.writeln('✅ *حالة السداد:* مدفوع بالكامل');
    } else {
      buffer.writeln('⏳ *المتبقي:* ${order.remainingAmount.format()}');
    }

    buffer.writeln('📦 *حالة الطلب:* ${order.executionStatus.labelAr}');
    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln(footer);

    return buffer.toString();
  }

  /// Generates a complete aesthetic customer account statement
  static String formatCustomerStatement({
    required Customer customer,
    required List<CustomerOrder> orders,
    String? storeName,
    String? footerMessage,
  }) {
    final store = storeName ?? 'ستوري بوتيك';
    final footer = footerMessage ?? 'شكراً لثقتكِ وتعاملكِ الراقي معنا ✨';
    final buffer = StringBuffer();

    buffer.writeln('🌸 *$store* 🌸');
    buffer.writeln('📑 *كشف حساب عميلة*');
    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln('👤 *العميلة:* ${customer.name}');
    buffer.writeln('📱 *الهاتف:* ${customer.phone}');
    buffer.writeln('📅 *تاريخ الكشف:* ${_formatDate(DateTime.now())}');
    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln('*سجل الطلبيات:*');

    Money totalOrders = Money.zero(customer.defaultCurrency);
    Money totalPaid = Money.zero(customer.defaultCurrency);
    Money totalRemaining = Money.zero(customer.defaultCurrency);

    if (orders.isEmpty) {
      buffer.writeln('لا توجد أي طلبيات مسجلة حتى الآن.');
    } else {
      for (final order in orders) {
        if (order.totalAmount.currency == customer.defaultCurrency) {
          totalOrders = totalOrders + order.totalAmount;
          totalPaid = totalPaid + order.paidAmount;
          totalRemaining = totalRemaining + order.remainingAmount;
        }

        buffer.writeln('• *طلبية #${order.orderNumber}* (${_formatDate(order.createdAt)})');
        buffer.writeln('  الإجمالي: ${order.totalAmount.format()} | المدفوع: ${order.paidAmount.format()}');
        buffer.writeln('  الحالة: ${order.executionStatus.labelAr} | السداد: ${order.paymentStatus.labelAr}');
      }
    }

    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln('📊 *الملخص المالي العام:*');
    buffer.writeln('💰 *إجمالي المشتريات:* ${totalOrders.format()}');
    buffer.writeln('💳 *إجمالي المسدد:* ${totalPaid.format()}');

    if (totalRemaining.isZero) {
      buffer.writeln('✅ *الرصيد المتبقي:* الحساب مسدد بالكامل 0');
    } else {
      buffer.writeln('⏳ *المتبقي المطلوب سداده:* ${totalRemaining.format()}');
    }

    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln(footer);

    return buffer.toString();
  }

  /// Launch WhatsApp with message
  static Future<bool> launchWhatsApp({
    required String phone,
    String? text,
  }) async {
    final cleaned = cleanPhoneNumber(phone);
    final encodedText = text != null ? Uri.encodeComponent(text) : '';
    final urlString = cleaned.isNotEmpty
        ? 'https://wa.me/$cleaned?text=$encodedText'
        : 'https://api.whatsapp.com/send?text=$encodedText';

    final uri = Uri.parse(urlString);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return true;
      }
    } catch (_) {}

    // Fallback: Copy to clipboard
    if (text != null && text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
    }
    return false;
  }

  /// Make standard phone call
  static Future<bool> makePhoneCall(String phone) async {
    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri.parse('tel:$cleaned');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        return true;
      }
    } catch (_) {}
    return false;
  }

  static String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
