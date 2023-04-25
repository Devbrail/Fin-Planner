import 'package:injectable/injectable.dart';

import '../../../core/enum/transaction.dart';
import '../../../domain/expense/repository/expense_repository.dart';
import '../data_sources/local_expense_data_manager.dart';
import '../model/expense_model.dart';

@Singleton(as: ExpenseRepository)
class ExpenseRepositoryImpl extends ExpenseRepository {
  ExpenseRepositoryImpl({required this.dataSource});

  final LocalExpenseDataManager dataSource;

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
        ExpenseModel(
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
  ExpenseModel? fetchExpenseFromId(int expenseId) =>
      dataSource.fetchExpenseFromId(expenseId);

  @override
  List<ExpenseModel> expenses() => dataSource.expenses();

  @override
  Future<void> deleteExpensesByAccountId(int accountId) =>
      dataSource.deleteExpensesByAccountId(accountId);

  @override
  Future<void> deleteExpensesByCategoryId(int categoryId) =>
      dataSource.deleteExpensesByCategoryId(categoryId);

  @override
  List<ExpenseModel> fetchExpensesFromAccountId(int accountId) =>
      dataSource.fetchExpensesFromAccountId(accountId);

  @override
  List<ExpenseModel> fetchExpensesFromCategoryId(int accountId) =>
      dataSource.fetchExpensesFromCategoryId(accountId);

  @override
  Future<void> updateExpense(
    int key,
    String name,
    double currency,
    DateTime time,
    int categoryId,
    int accountId,
    TransactionType transactionType,
    String? description,
  ) {
    return dataSource.updateExpense(
      ExpenseModel(
        name: name,
        currency: currency,
        time: time,
        categoryId: categoryId,
        accountId: accountId,
        type: transactionType,
        description: description,
        superId: key,
      ),
    );
  }

  @override
  Future<void> clearAll() => dataSource.clearAll();
}
