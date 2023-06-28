import 'package:paisa/src/core/enum/transaction_type.dart';
import 'package:paisa/src/domain/account/entities/account.dart';
import 'package:paisa/src/domain/category/entities/category.dart';

class EnhancedExpense {
  final Account account;
  final Category category;
  final double currency;
  final String name;
  final int id;
  final DateTime time;
  final TransactionType type;
  final String? description;

  EnhancedExpense({
    required this.account,
    required this.category,
    required this.currency,
    required this.name,
    required this.id,
    required this.time,
    required this.type,
    this.description,
  });
}
