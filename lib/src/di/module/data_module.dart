import 'dart:io';

import 'package:hive_flutter/adapters.dart';

import '../../core/enum/box_types.dart';
import '../../core/enum/card_type.dart';
import '../../core/enum/debt_type.dart';
import '../../core/enum/transaction.dart';
import '../../data/accounts/model/account.dart';
import '../../data/category/model/category.dart';
import '../../data/debt/models/debt.dart';
import '../../data/debt/models/transaction.dart';
import '../../data/expense/model/expense.dart';

Future<void> initHive() async {
  await Hive.initFlutter(Platform.isWindows ? 'paisa' : null);
  Hive
    ..registerAdapter(ExpenseAdapter())
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(AccountAdapter())
    ..registerAdapter(TransactionTypeAdapter())
    ..registerAdapter(DebtAdapter())
    ..registerAdapter(DebtTypeAdapter())
    ..registerAdapter(TransactionAdapter())
    ..registerAdapter(CardTypeAdapter());
  await hiveOpenBoxes();
}

Future<void> hiveOpenBoxes() async {
  await Hive.openBox<Transaction>(BoxType.transactions.name);
  await Hive.openBox<Expense>(BoxType.expense.name);
  await Hive.openBox<Category>(BoxType.category.name);
  await Hive.openBox<Account>(BoxType.accounts.name);
  await Hive.openBox<Debt>(BoxType.debts.name);
  await Hive.openBox<dynamic>(BoxType.settings.name);
}
