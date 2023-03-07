import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import '../../data/category/model/category.dart';

import '../../core/enum/box_types.dart';
import '../../data/accounts/model/account.dart';
import '../../data/debt/models/debt.dart';
import '../../data/debt/models/transaction.dart';
import '../../data/expense/model/expense.dart';

@module
abstract class HiveModule {
  @singleton
  @FactoryMethod(preResolve: true)
  Future<void> init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(ExpenseAdapter())
      ..registerAdapter(CategoryAdapter())
      ..registerAdapter(AccountAdapter())
      ..registerAdapter(TransactionTypeAdapter())
      ..registerAdapter(DebtAdapter())
      ..registerAdapter(DebtTypeAdapter())
      ..registerAdapter(TransactionAdapter())
      ..registerAdapter(CardTypeAdapter());
  }

  @FactoryMethod(preResolve: true)
  @Singleton()
  Future<Box<Expense>> get expenseBox async =>
      Hive.openBox<Expense>(BoxType.expense.name);

  @FactoryMethod(preResolve: true)
  @Singleton()
  Future<Box<Account>> get accountBox async =>
      Hive.openBox<Account>(BoxType.accounts.name);

  @FactoryMethod(preResolve: true)
  @Singleton()
  Future<Box<Category>> get categoryBox async =>
      Hive.openBox<Category>(BoxType.category.name);

  @FactoryMethod(preResolve: true)
  @Singleton()
  Future<Box<Debt>> get debtsBox async =>
      Hive.openBox<Debt>(BoxType.debts.name);

  @FactoryMethod(preResolve: true)
  @Singleton()
  Future<Box<Transaction>> get transactionsBox async =>
      Hive.openBox<Transaction>(BoxType.transactions.name);

  @FactoryMethod()
  @Singleton(signalsReady: true)
  @Named('settings')
  Future<Box<dynamic>> get boxDynamic async =>
      Hive.openBox<dynamic>(BoxType.settings.name);
}
