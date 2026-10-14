import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../orders/domain/entities/customer_order.dart';
import '../../../orders/domain/entities/order_item.dart';
import '../../../wallets/domain/entities/wallet.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void loadDashboard() {
    emit(HomeLoading());

    // Provide seed demonstration data based on Storee Yemen/SAR requirements
    final sampleWallets = [
      Wallet(
        id: 'w1',
        name: 'الكاش الشخصي',
        type: WalletType.cash,
        balances: {
          'YER': Money.fromMajor(450000, Currency.yer),
          'SAR': Money.fromMajor(1200, Currency.sar),
        },
      ),
      Wallet(
        id: 'w2',
        name: 'محفظة جيب / ون كاش',
        type: WalletType.electronicWallet,
        balances: {
          'YER': Money.fromMajor(280000, Currency.yer),
          'SAR': Money.zero(Currency.sar),
        },
      ),
      Wallet(
        id: 'w3',
        name: 'حساب بنك الكريمي',
        type: WalletType.bankAccount,
        balances: {
          'YER': Money.fromMajor(950000, Currency.yer),
          'SAR': Money.fromMajor(3400, Currency.sar),
        },
      ),
    ];

    final sampleOrders = [
      CustomerOrder(
        id: 'ord-101',
        customerId: 'cust-1',
        customerName: 'فاطمة الكاف',
        orderNumber: '#1042',
        executionStatus: OrderExecutionStatus.readyToDeliver,
        paymentStatus: OrderPaymentStatus.partial,
        currency: Currency.sar,
        items: [
          OrderItem(
            id: 'item-1',
            orderId: 'ord-101',
            title: 'فستان مخمل كحلي راقي',
            size: 'L',
            color: 'كحلي',
            quantity: 1,
            saleUnitPrice: Money.fromMajor(180, Currency.sar),
            unitCost: Money.fromMajor(110, Currency.sar),
            allocatedExtraCost: Money.fromMajor(15, Currency.sar),
          ),
        ],
        paidAmount: Money.fromMajor(100, Currency.sar),
        discountAmount: Money.zero(Currency.sar),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now(),
      ),
      CustomerOrder(
        id: 'ord-102',
        customerId: 'cust-2',
        customerName: 'منى باوزير',
        orderNumber: '#1043',
        executionStatus: OrderExecutionStatus.shipping,
        paymentStatus: OrderPaymentStatus.paid,
        currency: Currency.yer,
        items: [
          OrderItem(
            id: 'item-2',
            orderId: 'ord-102',
            title: 'حقيبة يد جلدية بيج',
            color: 'بيج',
            quantity: 1,
            saleUnitPrice: Money.fromMajor(32000, Currency.yer),
            unitCost: Money.fromMajor(21000, Currency.yer),
            allocatedExtraCost: Money.fromMajor(3000, Currency.yer),
          ),
        ],
        paidAmount: Money.fromMajor(32000, Currency.yer),
        discountAmount: Money.zero(Currency.yer),
        createdAt: DateTime.now().subtract(const Duration(hours: 18)),
        updatedAt: DateTime.now(),
      ),
    ];

    final receivables = {
      'SAR': Money.fromMajor(80, Currency.sar),
      'YER': Money.fromMajor(45000, Currency.yer),
    };

    final profits = {
      'SAR': Money.fromMajor(55, Currency.sar),
      'YER': Money.fromMajor(8000, Currency.yer),
    };

    emit(HomeLoaded(
      recentOrders: sampleOrders,
      wallets: sampleWallets,
      receivablesByCurrency: receivables,
      profitsByCurrency: profits,
      pendingOrdersCount: 4,
      readyToDeliverCount: 2,
    ));
  }
}
