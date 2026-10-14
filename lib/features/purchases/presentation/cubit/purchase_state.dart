import 'package:equatable/equatable.dart';
import '../../../orders/domain/entities/order_item.dart';
import '../../domain/entities/purchase_batch.dart';

sealed class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object?> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseLoaded extends PurchaseState {
  final List<PurchaseBatch> batches;
  final List<OrderItem> unassignedItems;

  const PurchaseLoaded({
    required this.batches,
    required this.unassignedItems,
  });

  @override
  List<Object?> get props => [batches, unassignedItems];
}

class PurchaseError extends PurchaseState {
  final String message;
  const PurchaseError(this.message);

  @override
  List<Object?> get props => [message];
}
