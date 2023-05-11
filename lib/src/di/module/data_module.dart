import 'dart:io';

import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/data/recurring/model/recurring.dart';

import '../../core/enum/box_types.dart';
import '../../core/enum/card_type.dart';
import '../../core/enum/debt_type.dart';
import '../../core/enum/filter_expense.dart';
import '../../core/enum/recurring_type.dart';
import '../../core/enum/transaction_type.dart';
import '../../data/accounts/model/account_model.dart';
import '../../data/category/model/category_model.dart';
import '../../data/debt/models/debt_model.dart';
import '../../data/debt/models/transactions_model.dart';
import '../../data/expense/model/expense_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter(Platform.isWindows ? 'paisa' : null);
  Hive
    ..registerAdapter(ExpenseModelAdapter())
    ..registerAdapter(CategoryModelAdapter())
    ..registerAdapter(AccountModelAdapter())
    ..registerAdapter(TransactionTypeAdapter())
    ..registerAdapter(DebtModelAdapter())
    ..registerAdapter(DebtTypeAdapter())
    ..registerAdapter(TransactionsModelAdapter())
    ..registerAdapter(CardTypeAdapter())
    ..registerAdapter(RecurringTypeAdapter())
    ..registerAdapter(RecurringModelAdapter())
    ..registerAdapter(FilterExpenseAdapter());
  await hiveOpenBoxes();
}

Future<void> hiveOpenBoxes() async {
  await Hive.openBox<TransactionsModel>(BoxType.transactions.name);
  await Hive.openBox<ExpenseModel>(BoxType.expense.name);
  await Hive.openBox<CategoryModel>(BoxType.category.name);
  await Hive.openBox<AccountModel>(BoxType.accounts.name);
  await Hive.openBox<DebtModel>(BoxType.debts.name);
  await Hive.openBox<RecurringModel>(BoxType.recurring.name);
  await Hive.openBox<dynamic>(BoxType.settings.name);
}
