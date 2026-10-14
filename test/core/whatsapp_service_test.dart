import 'package:flutter_test/flutter_test.dart';
import 'package:storee/core/money/currency.dart';
import 'package:storee/core/money/money.dart';
import 'package:storee/core/services/whatsapp_service.dart';
import 'package:storee/features/customers/domain/entities/customer.dart';
import 'package:storee/features/orders/domain/entities/customer_order.dart';
import 'package:storee/features/orders/domain/entities/order_item.dart';

void main() {
  group('WhatsAppService Tests', () {
    test('cleans local Yemeni numbers by prepending 967 country code', () {
      expect(WhatsAppService.cleanPhoneNumber('777123456'), '967777123456');
      expect(WhatsAppService.cleanPhoneNumber('+967 777 123 456'), '967777123456');
      expect(WhatsAppService.cleanPhoneNumber('00967777123456'), '967777123456');
    });

    test('cleans local Saudi numbers by prepending 966 country code', () {
      expect(WhatsAppService.cleanPhoneNumber('0501234567'), '966501234567');
      expect(WhatsAppService.cleanPhoneNumber('+966 50 123 4567'), '966501234567');
    });

    test('formats boutique receipt text with Arabic typography and financial breakdown', () {
      final now = DateTime(2026, 10, 14);
      final item1 = OrderItem(
        id: 'i1',
        orderId: 'o1',
        title: 'فستان مخمل كحلي راقي',
        size: 'L',
        color: 'كحلي',
        quantity: 2,
        saleUnitPrice: Money.fromMajor(180, Currency.sar),
      );

      final order = CustomerOrder(
        id: 'o1',
        customerId: 'c1',
        customerName: 'فاطمة الكاف',
        orderNumber: '#1042',
        executionStatus: OrderExecutionStatus.readyToDeliver,
        paymentStatus: OrderPaymentStatus.partial,
        currency: Currency.sar,
        items: [item1],
        paidAmount: Money.fromMajor(200, Currency.sar),
        discountAmount: Money.zero(Currency.sar),
        createdAt: now,
        updatedAt: now,
      );

      final invoiceText = WhatsAppService.formatOrderInvoice(order: order, storeName: 'بوتيك ياسمين');

      expect(invoiceText.contains('بوتيك ياسمين'), true);
      expect(invoiceText.contains('#1042'), true);
      expect(invoiceText.contains('فاطمة الكاف'), true);
      expect(invoiceText.contains('فستان مخمل كحلي راقي'), true);
      expect(invoiceText.contains('كحلي / L'), true);
      expect(invoiceText.contains('360.00'), true);
      expect(invoiceText.contains('200.00'), true);
      expect(invoiceText.contains('160.00'), true);
      expect(invoiceText.contains('جاهز للتسليم'), true);
    });

    test('formats boutique customer account statement with financial summary and order history', () {
      final customer = Customer(
        id: 'c1',
        name: 'سارة العمودي',
        phone: '777998877',
        defaultCurrency: Currency.sar,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final order1 = CustomerOrder(
        id: 'o1',
        customerId: 'c1',
        customerName: 'سارة العمودي',
        orderNumber: '501',
        executionStatus: OrderExecutionStatus.delivered,
        paymentStatus: OrderPaymentStatus.paid,
        currency: Currency.sar,
        items: const [],
        paidAmount: Money.fromMajor(100, Currency.sar),
        discountAmount: Money.zero(Currency.sar),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final statement = WhatsAppService.formatCustomerStatement(
        customer: customer,
        orders: [order1],
        storeName: 'أناقة عدن',
        footerMessage: 'شكراً لتعاملك الدائم معنا 💖',
      );

      expect(statement.contains('أناقة عدن'), true);
      expect(statement.contains('كشف حساب عميلة'), true);
      expect(statement.contains('سارة العمودي'), true);
      expect(statement.contains('777998877'), true);
      expect(statement.contains('طلبية #501'), true);
      expect(statement.contains('شكراً لتعاملك الدائم معنا 💖'), true);
    });
  });
}
