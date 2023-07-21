import 'package:equatable/equatable.dart';
import 'package:paisa/core/common_enum.dart';

class TransactionEntity extends Equatable {
  const TransactionEntity({
    this.name,
    this.currency,
    this.time,
    this.categoryId,
    this.accountId,
    this.type,
    this.description,
    this.superId,
  });

  final int? accountId;
  final int? categoryId;
  final double? currency;
  final String? description;
  final String? name;
  final int? superId;
  final DateTime? time;
  final TransactionType? type;

  @override
  List<Object?> get props => [
        name,
        currency,
        time,
        categoryId,
        accountId,
        type,
        description,
        superId,
      ];
  TransactionEntity copyWith({
    final int? accountId,
    final int? categoryId,
    final double? currency,
    final String? description,
    final String? name,
    final int? superId,
    final DateTime? time,
    final TransactionType? type,
  }) {
    return TransactionEntity(
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      name: name ?? this.name,
      superId: superId ?? this.superId,
      time: time ?? this.time,
      type: type ?? this.type,
    );
  }
}
