import 'package:equatable/equatable.dart';
import '../../../../core/money/currency.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final String phone;
  final Currency defaultCurrency;
  final String? notes;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.defaultCurrency,
    this.notes,
    this.isArchived = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Customer copyWith({
    String? id,
    String? name,
    String? phone,
    Currency? defaultCurrency,
    String? notes,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        defaultCurrency,
        notes,
        isArchived,
        createdAt,
        updatedAt,
      ];
}
