import 'dart:io';

import 'package:hive_flutter/adapters.dart';

import '../../core/enum/box_types.dart';
import '../../core/enum/card_type.dart';
import '../../core/enum/debt_type.dart';
import '../../core/enum/transaction.dart';
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
    ..registerAdapter(CardTypeAdapter());
  await hiveOpenBoxes();
}

Future<void> hiveOpenBoxes() async {
  await Hive.openBox<TransactionsModel>(BoxType.transactions.name);
  await Hive.openBox<ExpenseModel>(BoxType.expense.name);
  await Hive.openBox<CategoryModel>(BoxType.category.name);
  await Hive.openBox<AccountModel>(BoxType.accounts.name);
  await Hive.openBox<DebtModel>(BoxType.debts.name);
  await Hive.openBox<dynamic>(BoxType.settings.name);
}
