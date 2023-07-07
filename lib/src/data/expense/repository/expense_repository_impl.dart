import 'package:injectable/injectable.dart';

import '../../../core/enum/transaction_type.dart';
import '../../../domain/expense/repository/expense_repository.dart';
import '../data_sources/local_expense_data_manager.dart';
import '../model/expense_model.dart';

@Singleton(as: ExpenseRepository)
class ExpenseRepositoryImpl extends ExpenseRepository {
  ExpenseRepositoryImpl({
    required this.dataSource,
  });

  final ExpenseLocalDataManager dataSource;

  @override
  Future<void> addExpense(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactionType transactionType,
    String? description,
    int? fromAccountId,
    int? toAccountId,
    double transferAmount,
  ) async {
    return dataSource.add(
      ExpenseModel(
        name: name,
        currency: amount,
        time: time,
        categoryId: category,
        accountId: account,
        type: transactionType,
        description: description,
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        transferAmount: transferAmount,
      ),
    );
  }

  @override
  Future<void> clearAll() => dataSource.clear();

  @override
  Future<void> clearExpense(int expenseId) async {
    return dataSource.deleteById(expenseId);
  }

  @override
  Future<void> deleteExpensesByAccountId(int accountId) {
    return dataSource.deleteByAccountId(accountId);
  }

  @override
  Future<void> deleteExpensesByCategoryId(int categoryId) {
    return dataSource.deleteByCategoryId(categoryId);
  }

  @override
  List<ExpenseModel> expenses() => dataSource.expenses();

  @override
  ExpenseModel? fetchExpenseFromId(int expenseId) {
    return dataSource.findById(expenseId);
  }

  @override
  List<ExpenseModel> fetchExpensesFromAccountId(int accountId) {
    return dataSource.findByAccountId(accountId);
  }

  @override
  List<ExpenseModel> fetchExpensesFromCategoryId(int accountId) {
    return dataSource.findByCategoryId(accountId);
  }

  @override
  List<ExpenseModel> filterExpenses(
    String query,
    int? accountId,
    int? categoryId,
  ) {
    return dataSource.filterExpenses(query, accountId, categoryId);
  }

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
    return dataSource.update(
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
}
