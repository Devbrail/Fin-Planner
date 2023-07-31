import 'package:paisa/core/common_enum.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';

extension CombinedTransactionsHelper on List<CombinedTransactionEntity> {
  double get total => fold(
      0, (previousValue, element) => previousValue + (element.currency ?? 0));

  double get fullTotal => totalIncome - totalExpense;

  List<CombinedTransactionEntity> get expenseList =>
      where((CombinedTransactionEntity element) =>
          element.type == TransactionType.expense).toList();

  List<CombinedTransactionEntity> get incomeList =>
      where((CombinedTransactionEntity element) =>
          element.type == TransactionType.income).toList();

  double get totalExpense =>
      expenseList.map((CombinedTransactionEntity e) => e.currency).fold<double>(
          0,
          (double previousValue, double? element) =>
              previousValue + (element ?? 0));

  double get totalIncome =>
      incomeList.map((CombinedTransactionEntity e) => e.currency).fold<double>(
          0,
          (double previousValue, double? element) =>
              previousValue + (element ?? 0));
}
