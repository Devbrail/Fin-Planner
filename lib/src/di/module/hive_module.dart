import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../core/enum/box_types.dart';
import '../../data/accounts/model/account_model.dart';
import '../../data/category/model/category_model.dart';
import '../../data/debt/models/debt_model.dart';
import '../../data/debt/models/transactions_model.dart';
import '../../data/expense/model/expense_model.dart';

@module
abstract class HiveModule {
  @singleton
  Box<ExpenseModel> get expenseBox =>
      Hive.box<ExpenseModel>(BoxType.expense.name);

  @singleton
  Box<AccountModel> get accountBox =>
      Hive.box<AccountModel>(BoxType.accounts.name);

  @singleton
  Box<CategoryModel> get categoryBox =>
      Hive.box<CategoryModel>(BoxType.category.name);

  @singleton
  Box<DebtModel> get debtsBox => Hive.box<DebtModel>(BoxType.debts.name);

  @singleton
  Box<TransactionsModel> get transactionsBox =>
      Hive.box<TransactionsModel>(BoxType.transactions.name);

  @singleton
  @Named('settings')
  Box<dynamic> get boxDynamic => Hive.box<dynamic>(BoxType.settings.name);
}
