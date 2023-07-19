import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/core/constants/constants.dart';
import 'package:paisa/core/enum/filter_expense.dart';
import 'package:paisa/core/enum/transaction_type.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/account/domain/use_case/get_account_use_case.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/category/domain/use_case/category_use_case.dart';
import 'package:paisa/features/transaction/domain/entities/expense.dart';
import 'package:paisa/features/transaction/domain/use_case/expense_use_case.dart';
import 'package:paisa/features/settings/domain/use_case/setting_use_case.dart';

@singleton
class SummaryController {
  SummaryController(
    this.settingsUseCase, {
    required this.getAccountUseCase,
    required this.getCategoryUseCase,
    required this.getExpensesFromCategoryIdUseCase,
  });

  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier =
      ValueNotifier<DateTimeRange?>(null);

  late final FilterExpense filterExpense = settingsUseCase.get<FilterExpense>(
    selectedFilterExpenseKey,
    defaultValue: FilterExpense.daily,
  );

  late final ValueNotifier<FilterExpense> filterExpenseNotifier =
      ValueNotifier<FilterExpense>(filterExpense);

  final GetAccountUseCase getAccountUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final GetExpensesFromCategoryIdUseCase getExpensesFromCategoryIdUseCase;
  final SettingsUseCase settingsUseCase;
  late final FilterExpense sortHomeExpense = settingsUseCase.get<FilterExpense>(
    selectedHomeFilterExpenseKey,
    defaultValue: FilterExpense.daily,
  );

  late final ValueNotifier<FilterExpense> sortHomeExpenseNotifier =
      ValueNotifier<FilterExpense>(sortHomeExpense);

  final ValueNotifier<TransactionType> typeNotifier =
      ValueNotifier<TransactionType>(TransactionType.income);

  CategoryEntity? fetchCategoryFromId(int categoryId) =>
      getCategoryUseCase(categoryId);

  AccountEntity? fetchAccountFromId(int accountId) =>
      getAccountUseCase(params: accountId);

  List<Expense> fetchExpensesFromCategoryId(int categoryId) =>
      getExpensesFromCategoryIdUseCase(categoryId);
}
