import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import '../main.dart';
import 'data/settings/authenticate.dart';

import 'core/enum/box_types.dart';
import 'core/enum/card_type.dart';
import 'core/enum/debt_type.dart';
import 'core/enum/transaction.dart';
import 'data/accounts/data_sources/account_local_data_source.dart';
import 'data/accounts/data_sources/account_local_data_source_impl.dart';
import 'data/accounts/model/account.dart';
import 'data/accounts/repository/account_repository_impl.dart';
import 'data/category/data_sources/category_local_data_source.dart';
import 'data/category/data_sources/category_local_data_source_impl.dart';
import 'data/category/model/category.dart';
import 'data/category/repository/category_repository_impl.dart';
import 'data/debt/data_sources/debt_local_data_source.dart';
import 'data/debt/data_sources/debt_local_data_source_impl.dart';
import 'data/debt/models/debt.dart';
import 'data/debt/models/transaction.dart';
import 'data/debt/repository/debt_repository_impl.dart';
import 'data/expense/data_sources/expense_manager_local_data_source.dart';
import 'data/expense/data_sources/expense_manager_local_data_source_impl.dart';
import 'data/expense/model/expense.dart';
import 'data/expense/repository/expense_repository_impl.dart';
import 'data/settings/file_handler.dart';
import 'domain/account/repository/account_repository.dart';
import 'domain/account/use_case/account_use_case.dart';
import 'domain/category/repository/category_repository.dart';
import 'domain/category/use_case/category_use_case.dart';
import 'domain/debt/repository/debit_repository.dart';
import 'domain/debt/use_case/debt_use_case.dart';
import 'domain/expense/repository/expense_repository.dart';
import 'domain/expense/use_case/expense_use_case.dart';
import 'presentation/accounts/bloc/accounts_bloc.dart';
import 'presentation/category/bloc/category_bloc.dart';
import 'presentation/debits/cubit/debts_cubit.dart';
import 'presentation/expense/bloc/expense_bloc.dart';
import 'presentation/home/bloc/home_bloc.dart';
import 'presentation/login/bloc/currency_selector_bloc.dart';

Future<void> setupLocator() async {
  await _setupHive();
  _localSources();
  _setupRepository();
  //_setupUseCase();
  //_setupBloc();
}

Future<void> _setupHive() async {
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

  /* final transactionBox =
      await Hive.openBox<Transaction>(BoxType.transactions.name);
  getIt.registerLazySingleton<Box<Transaction>>(() => transactionBox);

  final expenseBox = await Hive.openBox<Expense>(BoxType.expense.name);
  getIt.registerLazySingleton<Box<Expense>>(() => expenseBox);

  final categoryBox = await Hive.openBox<Category>(BoxType.category.name);
  getIt.registerLazySingleton<Box<Category>>(() => categoryBox);

  final accountBox = await Hive.openBox<Account>(BoxType.accounts.name);
  getIt.registerLazySingleton<Box<Account>>(() => accountBox);

  final debtBox = await Hive.openBox<Debt>(BoxType.debts.name);
  getIt.registerLazySingleton<Box<Debt>>(() => debtBox); */

  /* final boxDynamic = await Hive.openBox(BoxType.settings.name);
  getIt.registerLazySingleton<Box<dynamic>>(() => boxDynamic,
      instanceName: BoxType.settings.name); */
}

void _localSources() {
  /* getIt.registerLazySingletonAsync<LocalExpenseManagerDataSource>(
      () async => LocalExpenseManagerDataSourceImpl(getIt.get()));
  getIt.registerLazySingletonAsync<LocalCategoryManagerDataSource>(
      () async => LocalCategoryManagerDataSourceImpl(getIt.get()));
  getIt.registerLazySingletonAsync<LocalAccountManagerDataSource>(
      () async => LocalAccountManagerDataSourceImpl(getIt.get())); 
  getIt.registerLazySingletonAsync<DebtLocalDataSource>(
      () async => DebtLocalDataSourceImpl(
            debtBox: getIt.get(),
            transactionsBox: getIt.get(),
          ));*/
  getIt.registerLazySingletonAsync<FileHandler>(() async => FileHandler());
  getIt.registerSingletonAsync(() async => Authenticate());
}

void _setupRepository() {
  /* getIt.registerLazySingletonAsync<ExpenseRepository>(
    () async => ExpenseRepositoryImpl(
      dataSource: await getIt.getAsync<LocalExpenseManagerDataSource>(),
    ),
  );
  getIt.registerLazySingletonAsync<CategoryRepository>(
    () async => CategoryRepositoryImpl(
      dataSources: await getIt.getAsync<LocalCategoryManagerDataSource>(),
    ),
  );
  getIt.registerLazySingletonAsync<AccountRepository>(
    () async => AccountRepositoryImpl(
      dataSource: await getIt.getAsync<LocalAccountManagerDataSource>(),
    ),
  );
  getIt.registerLazySingletonAsync<DebtRepository>(
    () async => DebtRepositoryImpl(
      dataSource: await getIt.getAsync(),
    ),
  ); */
}

void _setupUseCase() {
  /*  getIt.registerLazySingletonAsync(() async =>
      GetExpenseUseCase(expenseRepository: await getIt.getAsync()));
  getIt.registerLazySingletonAsync(() async =>
      DeleteExpenseUseCase(expenseRepository: await getIt.getAsync()));
  getIt.registerLazySingletonAsync(() async =>
      AddExpenseUseCase(expenseRepository: await getIt.getAsync()));
  getIt.registerLazySingletonAsync(() async =>
      GetCategoryUseCase(categoryRepository: await getIt.getAsync()));
  getIt.registerLazySingletonAsync(() async =>
      AddCategoryUseCase(categoryRepository: await getIt.getAsync()));
  getIt.registerLazySingletonAsync(() async =>
      DeleteCategoryUseCase(categoryRepository: await getIt.getAsync()));
  getIt.registerLazySingletonAsync(() async =>
      GetAccountUseCase(accountRepository: await getIt.getAsync()));
  getIt.registerLazySingletonAsync(() async =>
      AddAccountUseCase(accountRepository: await getIt.getAsync()));
  getIt.registerLazySingletonAsync(() async =>
      DeleteAccountUseCase(accountRepository: await getIt.getAsync()));
  getIt.registerLazySingletonAsync(
      () async => DebtUseCase(debtRepository: await getIt.getAsync())); */
}

void _setupBloc() {
  /* getIt.registerFactoryAsync(() async => CurrencySelectorBloc(
        accounts: getIt.get(),
        categories: getIt.get(),
        settings:
            getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name),
      ));
  getIt.registerFactoryAsync(() async => CategoryBloc(
        getCategoryUseCase: await getIt.getAsync(),
        addCategoryUseCase: await getIt.getAsync(),
        deleteCategoryUseCase: await getIt.getAsync(),
      ));
  getIt.registerFactoryAsync(() async => ExpenseBloc(
        accountUseCase: await getIt.getAsync(),
        expenseUseCase: await getIt.getAsync(),
        addExpenseUseCase: await getIt.getAsync(),
        deleteExpenseUseCase: await getIt.getAsync(),
      ));
  getIt.registerFactoryAsync(() async => AccountsBloc(
        getAccountUseCase: await getIt.getAsync(),
        addAccountUseCase: await getIt.getAsync(),
        deleteAccountUseCase: await getIt.getAsync(),
      ));
  getIt.registerFactory(() =>
      HomeBloc(getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name)));
  getIt.registerFactoryAsync(
      () async => DebtsBloc(useCase: await getIt.getAsync())); */
}
