import 'package:paisa/core/common_enum.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/category/domain/entities/category.dart';

class CombinedTransactionEntity {
  final AccountEntity? account;
  final CategoryEntity? category;
  final double? currency;
  final String? description;
  final String? name;
  final int? superId;
  final DateTime? time;
  final TransactionType? type;

  CombinedTransactionEntity({
    this.account,
    this.category,
    this.currency,
    this.description,
    this.name,
    this.superId,
    this.time,
    this.type,
  });
}
