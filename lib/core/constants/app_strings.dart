abstract final class AppStrings {
  static const String appName = 'ستوري';
  static const String appNameEn = 'Storee';
  static const String appSlogan = 'كل طلب، وكل ريال، في مكانه';

  // Navigation Tabs
  static const String navHome = 'الرئيسية';
  static const String navOrders = 'الطلبات';
  static const String navCustomers = 'العميلات';
  static const String navWallets = 'الخزنات';
  static const String navReports = 'التقارير';

  // Quick Action Sheet
  static const String quickAdd = 'إضافة سريعة';
  static const String newOrder = 'طلبية جديدة';
  static const String newCustomer = 'عميلة جديدة';
  static const String newPayment = 'تسجيل دفعة';
  static const String newExpense = 'تسجيل مصروف';
  static const String newTransfer = 'تحويل بين الخزنات';
  static const String newPurchaseBatch = 'شراء جماعي';

  // Orders
  static const String orderNumber = 'رقم الطلب';
  static const String orderStatus = 'حالة التنفيذ';
  static const String paymentStatus = 'حالة الدفع';
  static const String totalAmount = 'الإجمالي';
  static const String paidAmount = 'المدفوع';
  static const String remainingAmount = 'المتبقي';
  static const String estimatedProfit = 'الربح التقديري';
  static const String confirmedProfit = 'الربح المحقق';

  // Order Execution Statuses
  static const String statusNew = 'جديد';
  static const String statusConfirmed = 'مؤكد';
  static const String statusPurchased = 'تم الشراء';
  static const String statusShipping = 'قيد الشحن';
  static const String statusArrived = 'وصل';
  static const String statusReadyToDeliver = 'جاهز للتسليم';
  static const String statusDelivered = 'تم التسليم';
  static const String statusCancelled = 'ملغي';

  // Payment Statuses
  static const String paymentUnpaid = 'غير مدفوع';
  static const String paymentPartial = 'مدفوع جزئياً';
  static const String paymentPaid = 'مدفوع بالكامل';
  static const String paymentRefunded = 'مسترد';

  // Wallets & Finance
  static const String totalBalance = 'إجمالي الأرصدة';
  static const String cashWallet = 'كاش';
  static const String bankAccount = 'حساب بنكي';
  static const String eWallet = 'محفظة إلكترونية';
  static const String customWallet = 'خزنة مخصصة';
  static const String receivablesFromCustomers = 'مستحقات عند العميلات';
  static const String payablesToSuppliers = 'مستحقات للموردين';

  // Currencies
  static const String currencyYer = 'ريال يمني';
  static const String currencySar = 'ريال سعودي';
  static const String currencyUsd = 'دولار أمريكي';

  // Warnings & Rule Messages
  static const String currencyMismatchError = 'لا يمكن جمع أو طرح مبالغ من عملات مختلفة دون تحويل صريح.';
  static const String zeroOrNegativeError = 'المبلغ يجب أن يكون أكبر من الصفر.';
}
