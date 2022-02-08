import 'package:intl/intl.dart';

import '../../../common/constants/currency.dart';
import '../../../common/constants/time.dart';
import '../../../common/constants/util.dart';
import '../../../common/enum/filter_days.dart';
import '../../../common/enum/transaction.dart';
import '../../../domain/landing/repository/expense_repository.dart';
import '../datasources/expense_manager_data_source.dart';
import '../model/expense.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  ExpenseRepositoryImpl({
    required this.dataSource,
  });

  List<Expense> expensesList = [];
  final ExpenseManagerDataSource dataSource;
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
    TransactonType transactonType,
  ) async {
    final expense = Expense(
      name: name,
      currency: amount,
      time: time,
      categoryId: category,
      accountId: account,
      type: transactonType,
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
    return getFormattedCurrency(total);
  }

  String _readableMonth(DateTime time) {
    return DateFormat('MMMM').format(time);
  }

  @override
  Future<void> clearExpense(Expense expense) async {
    await dataSource.clearExpense(expense.key);
  }

  @override
  Future<String> totalExpenses(TransactonType type) async {
    final List<Expense> expenses = await fetchAndCache();
    final total = expenses
        .where((element) => element.type == type)
        .map((e) => e.currency)
        .fold<double>(0, (previousValue, element) => previousValue + element);
    return getFormattedCurrency(total);
  }

  Future<List<Expense>> fetchAndCache({bool isRefresh = false}) async {
    if (expensesList.isEmpty || isRefresh) {
      expensesList = await dataSource.expenses();
    }
    return expensesList;
  }
}
