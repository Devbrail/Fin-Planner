import 'package:intl/intl.dart';

import '../../../common/constants/currency.dart';
import '../../../common/constants/list_util.dart';
import '../../../common/constants/time_extension.dart';
import '../../../common/enum/filter_days.dart';
import '../../../common/enum/transaction.dart';
import '../../../domain/expense/repository/expense_repository.dart';
import '../data_sources/expense_manager_local_data_source.dart';
import '../model/expense.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  ExpenseRepositoryImpl({
    required this.dataSource,
  });

  List<Expense> expensesList = [];
  final ExpenseManagerLocalDataSource dataSource;
  @override
  Future<void> updateExpense(Expense expense) async {
    await dataSource.addOrUpdateExpense(expense);
  }

  @override
  Future<void> addExpense(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactionType transactionType,
  ) async {
    final expense = Expense(
      name: name,
      currency: amount,
      time: time,
      categoryId: category,
      accountId: account,
      type: transactionType,
    );
    await dataSource.addOrUpdateExpense(expense);
  }

  @override
  Future<void> clearExpenses() async {
    await dataSource.clearExpenses();
  }

  @override
  Future<Map<String, List<Expense>>> expenses(bool isRefresh) async {
    final expenses = await fetchAndCache(isRefresh: isRefresh);
    expenses.sort((a, b) => b.time.compareTo(a.time));
    final Map<String, List<Expense>> groupedExpense =
        groupBy(expenses, (Expense expense) => _readableMonth(expense.time));
    return groupedExpense;
  }

  @override
  Future<String> filterExpensesTotal(FilterDays filterDays) async {
    final List<Expense> expenses = await fetchAndCache();
    expenses.sort((a, b) => b.time.compareTo(a.time));
    final total = expenses
        .where((element) {
          final int days = element.time.daysDifference;
          return filterDays.filterDate(days);
        })
        .map((e) => e.currency)
        .fold<double>(0, (previousValue, element) => previousValue + element);
    return formattedCurrency(total);
  }

  String _readableMonth(DateTime time) {
    return DateFormat('MMMM').format(time);
  }

  @override
  Future<void> clearExpense(int expenseId) async {
    await dataSource.clearExpense(expenseId);
  }

  @override
  Future<String> totalExpenses(TransactionType type) async {
    final List<Expense> expenses = await fetchAndCache();
    final total = expenses
        .where((element) => element.type == type)
        .map((e) => e.currency)
        .fold<double>(0, (previousValue, element) => previousValue + element);
    return formattedCurrency(total);
  }

  Future<List<Expense>> fetchAndCache({bool isRefresh = false}) async {
    if (expensesList.isEmpty || isRefresh) {
      expensesList = await dataSource.expenses();
    }
    return expensesList;
  }

  @override
  Future<Expense?> fetchExpenseFromId(int expenseId) =>
      dataSource.fetchExpenseFromId(expenseId);
}
