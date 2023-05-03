import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/account/use_case/account_use_case.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/category/use_case/category_use_case.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';
import '../../settings/bloc/settings_controller.dart';

@singleton
class SummaryController {
  final GetAccountUseCase getAccountUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final GetExpensesFromCategoryIdUseCase getExpensesFromCategoryIdUseCase;
  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier =
      ValueNotifier<DateTimeRange?>(null);
  final FilterExpense filterExpense =
      getIt.get<SettingsController>().fetchFilterExpense;

  final FilterThisExpense filterThisExpense =
      getIt.get<SettingsController>().fetchFilterThisExpense;

  late final ValueNotifier<FilterExpense> filterExpenseNotifier =
      ValueNotifier<FilterExpense>(filterExpense);

  late final ValueNotifier<FilterThisExpense> filterThisExpenseNotifier =
      ValueNotifier<FilterThisExpense>(filterThisExpense);

  SummaryController({
    required this.getAccountUseCase,
    required this.getCategoryUseCase,
    required this.getExpensesFromCategoryIdUseCase,
  });

  Category? getCategory(int categoryId) => getCategoryUseCase(categoryId);
  Account? getAccount(int accountId) => getAccountUseCase(accountId);
  List<Expense> getExpensesFromCategoryId(int categoryId) =>
      getExpensesFromCategoryIdUseCase(categoryId);
}
