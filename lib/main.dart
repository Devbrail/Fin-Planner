import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/core/enum/box_types.dart';
import 'src/core/enum/card_type.dart';
import 'src/core/enum/debt_type.dart';
import 'src/core/enum/transaction.dart';
import 'src/data/accounts/model/account.dart';
import 'src/data/category/model/category.dart' as box;
import 'src/data/debt/models/debt.dart';
import 'src/data/debt/models/transaction.dart';
import 'src/data/expense/model/expense.dart';
import 'src/di/di.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await fn();
  await hiveOpenBoxes();
  await configInjector(getIt);
  if (!kIsWeb) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  runApp(const PaisaApp());
}

Future<void> fn() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(ExpenseAdapter())
    ..registerAdapter(box.CategoryAdapter())
    ..registerAdapter(AccountAdapter())
    ..registerAdapter(TransactionTypeAdapter())
    ..registerAdapter(DebtAdapter())
    ..registerAdapter(DebtTypeAdapter())
    ..registerAdapter(TransactionAdapter())
    ..registerAdapter(CardTypeAdapter());
}

Future<void> hiveOpenBoxes() async {
  await Hive.openBox<Transaction>(BoxType.transactions.name);
  await Hive.openBox<Expense>(BoxType.expense.name);
  await Hive.openBox<box.Category>(BoxType.category.name);
  await Hive.openBox<Account>(BoxType.accounts.name);
  await Hive.openBox<Debt>(BoxType.debts.name);
  await Hive.openBox<dynamic>(BoxType.settings.name);
}
