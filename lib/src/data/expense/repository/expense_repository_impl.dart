import '../../../core/enum/transaction.dart';
import '../../../domain/expense/repository/expense_repository.dart';
import '../data_sources/expense_manager_local_data_source.dart';
import '../model/expense.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  ExpenseRepositoryImpl({required this.dataSource});

  final LocalExpenseManagerDataSource dataSource;

  @override
  Future<void> addExpense(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactionType transactionType,
    String? description,
  ) async =>
      dataSource.addOrUpdateExpense(
        Expense(
          name: name,
          currency: amount,
          time: time,
          categoryId: category,
          accountId: account,
          type: transactionType,
          description: description,
        ),
      );

  @override
  Future<void> clearExpense(int expenseId) async =>
      dataSource.clearExpense(expenseId);

  @override
  Future<Expense?> fetchExpenseFromId(int expenseId) =>
      dataSource.fetchExpenseFromId(expenseId);
}
