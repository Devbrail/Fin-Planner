import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../core/enum/box_types.dart';
import '../../data/accounts/model/account.dart';
import '../../data/category/model/category.dart';
import '../../data/debt/models/debt.dart';
import '../../data/debt/models/transaction.dart';
import '../../data/expense/model/expense.dart';

@module
abstract class HiveModule {
  @factoryMethod
  @singleton
  Box<Expense> get expenseBox => Hive.box<Expense>(BoxType.expense.name);

  @FactoryMethod(preResolve: true)
  @singleton
  Box<Account> get accountBox => Hive.box<Account>(BoxType.accounts.name);

  @FactoryMethod(preResolve: true)
  @singleton
  Box<Category> get categoryBox => Hive.box<Category>(BoxType.category.name);

  @FactoryMethod(preResolve: true)
  @singleton
  Box<Debt> get debtsBox => Hive.box<Debt>(BoxType.debts.name);

  @FactoryMethod(preResolve: true)
  @singleton
  Box<Transaction> get transactionsBox =>
      Hive.box<Transaction>(BoxType.transactions.name);

  @FactoryMethod()
  @singleton
  @Named('settings')
  Box<dynamic> get boxDynamic => Hive.box<dynamic>(BoxType.settings.name);
}
