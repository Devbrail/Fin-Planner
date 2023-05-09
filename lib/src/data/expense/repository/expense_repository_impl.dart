import 'package:injectable/injectable.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/core/enum/recurring_type.dart';

import '../../../core/enum/transaction.dart';
import '../../../domain/expense/repository/expense_repository.dart';
import '../data_sources/local_expense_data_manager.dart';
import '../model/expense_model.dart';

@Singleton(as: ExpenseRepository)
class ExpenseRepositoryImpl extends ExpenseRepository {
  ExpenseRepositoryImpl({
    required this.dataSource,
  });

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
    int? fromAccountId,
    int? toAccountId,
    double transferAmount,
  ) async {
    return dataSource.addOrUpdateExpense(
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
  Future<void> clearExpense(int expenseId) async {
    return dataSource.clearExpense(expenseId);
  }

  @override
  ExpenseModel? fetchExpenseFromId(int expenseId) {
    return dataSource.fetchExpenseFromId(expenseId);
  }

  @override
  List<ExpenseModel> expenses() => dataSource.expenses();

  @override
  Future<void> deleteExpensesByAccountId(int accountId) {
    return dataSource.deleteExpensesByAccountId(accountId);
  }

  @override
  Future<void> deleteExpensesByCategoryId(int categoryId) {
    return dataSource.deleteExpensesByCategoryId(categoryId);
  }

  @override
  List<ExpenseModel> fetchExpensesFromAccountId(int accountId) {
    return dataSource.fetchExpensesFromAccountId(accountId);
  }

  @override
  List<ExpenseModel> fetchExpensesFromCategoryId(int accountId) {
    return dataSource.fetchExpensesFromCategoryId(accountId);
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

  @override
  Future<void> addRecurringExpense(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactionType transactionType,
    String? description,
    RecurringType recurringType,
  ) async {
    return dataSource.addOrUpdateExpense(
      ExpenseModel(
        name: name,
        currency: amount,
        time: time,
        categoryId: category,
        accountId: account,
        type: transactionType,
        description: description,
        recurringType: recurringType,
        recurringDate: time,
      ),
    );
  }

  @override
  Future<void> checkForRecurring() async {
    final List<ExpenseModel> recurringExpenses =
        expenses().toEntities().recurringList;
    final now = DateTime.now();
    for (final ExpenseModel expenseModel in recurringExpenses) {
      if (expenseModel.recurringDate == null) return;
      if (expenseModel.type == TransactionType.recurring &&
          expenseModel.recurringDate!.isBefore(now)) {
        final nextTime = expenseModel.recurringType!.getTime;
        final ExpenseModel currentExpense = expenseModel.copyWith(
          type: TransactionType.expense,
          time: now,
        );
        final ExpenseModel saveExpense = expenseModel.copyWith(
          recurringDate: expenseModel.recurringDate?.add(nextTime),
        );
        await dataSource.addOrUpdateExpense(currentExpense);
        await dataSource.addOrUpdateExpense(saveExpense);
        await dataSource.clearExpense(expenseModel.superId!);
      }
    }
  }

  @override
  List<ExpenseModel> filterExpenses(
    String query,
    int? accountId,
    int? categoryId,
  ) {
    return dataSource.filterExpenses(query, accountId, categoryId);
  }
}
