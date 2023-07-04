import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.dart';
import '../../../core/enum/filter_expense.dart';
import '../../../core/enum/transaction_type.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/account/use_case/account_use_case.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/category/use_case/category_use_case.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';
import '../../settings/controller/settings_controller.dart';

@singleton
class SummaryController {
  SummaryController({
    required this.getAccountUseCase,
    required this.getCategoryUseCase,
    required this.getExpensesFromCategoryIdUseCase,
  });

  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier =
      ValueNotifier<DateTimeRange?>(null);

  final FilterExpense filterExpense =
      getIt.get<SettingsController>().fetchFilterExpense();

  late final ValueNotifier<FilterExpense> filterExpenseNotifier =
      ValueNotifier<FilterExpense>(filterExpense);

  final GetAccountUseCase getAccountUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final GetExpensesFromCategoryIdUseCase getExpensesFromCategoryIdUseCase;
  final FilterExpense sortHomeExpense =
      getIt.get<SettingsController>().fetchFilterExpense(isHome: true);

  late final ValueNotifier<FilterExpense> sortHomeExpenseNotifier =
      ValueNotifier<FilterExpense>(sortHomeExpense);

  final ValueNotifier<TransactionType> typeNotifier =
      ValueNotifier<TransactionType>(TransactionType.income);

  Category? fetchCategoryFromId(int categoryId) =>
      getCategoryUseCase(categoryId);

  Account? fetchAccountFromId(int accountId) => getAccountUseCase(accountId);

  List<Expense> fetchExpensesFromCategoryId(int categoryId) =>
      getExpensesFromCategoryIdUseCase(categoryId);
}
