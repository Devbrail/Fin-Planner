import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

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
import 'data/settings/settings_service.dart';
import 'domain/account/repository/account_repository.dart';
import 'domain/account/use_case/account_use_case.dart';
import 'domain/category/repository/category_repository.dart';
import 'domain/category/use_case/category_use_case.dart';
import 'domain/debt/repository/debit_repository.dart';
import 'domain/debt/use_case/debt_use_case.dart';
import 'domain/expense/repository/expense_repository.dart';
import 'domain/expense/use_case/expense_use_case.dart';
import 'presentation/accounts/bloc/accounts_bloc.dart';
import 'presentation/budget_overview/cubit/filter_date_cubit.dart';
import 'presentation/category/bloc/category_bloc.dart';
import 'presentation/debits/cubit/debts_cubit.dart';
import 'presentation/expense/bloc/expense_bloc.dart';
import 'presentation/filter_widget/cubit/filter_cubit.dart';
import 'presentation/home/bloc/home_bloc.dart';
import 'presentation/settings/cubit/user_image_cubit.dart';
import 'presentation/splash/bloc/splash_bloc.dart';
import 'presentation/summary/cubit/summary_cubit.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await _setupHive();
  _localSources();
  _setupRepository();
  _setupUseCase();
  _setupBloc();
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

  final transactionBox =
      await Hive.openBox<Transaction>(BoxType.transactions.stringValue);
  locator.registerLazySingleton<Box<Transaction>>(() => transactionBox);

  final expenseBox = await Hive.openBox<Expense>(BoxType.expense.stringValue);
  locator.registerLazySingleton<Box<Expense>>(() => expenseBox);

  final categoryBox =
      await Hive.openBox<Category>(BoxType.category.stringValue);
  locator.registerLazySingleton<Box<Category>>(() => categoryBox);

  final accountBox = await Hive.openBox<Account>(BoxType.accounts.stringValue);
  locator.registerLazySingleton<Box<Account>>(() => accountBox);

  final debtBox = await Hive.openBox<Debt>(BoxType.debts.stringValue);
  locator.registerLazySingleton<Box<Debt>>(() => debtBox);

  final boxDynamic = await Hive.openBox(BoxType.settings.stringValue);
  locator.registerLazySingleton<Box<dynamic>>(() => boxDynamic,
      instanceName: BoxType.settings.stringValue);
}

void _localSources() {
  locator.registerLazySingletonAsync<LocalExpenseManagerDataSource>(
      () async => LocalExpenseManagerDataSourceImpl(locator.get()));
  locator.registerLazySingletonAsync<LocalCategoryManagerDataSource>(
      () async => LocalCategoryManagerDataSourceImpl(locator.get()));
  locator.registerLazySingletonAsync<LocalAccountManagerDataSource>(
      () async => LocalAccountManagerDataSourceImpl(locator.get()));
  locator.registerLazySingletonAsync<DebtLocalDataSource>(
      () async => DebtLocalDataSourceImpl(
            debtBox: locator.get(),
            transactionsBox: locator.get(),
          ));
  locator.registerLazySingletonAsync<SettingsService>(
      () async => SettingsServiceImpl(locator.get()));
  locator.registerLazySingletonAsync<FileHandler>(() async => FileHandler());
}

void _setupRepository() {
  locator.registerLazySingletonAsync<ExpenseRepository>(
    () async => ExpenseRepositoryImpl(
      dataSource: await locator.getAsync<LocalExpenseManagerDataSource>(),
    ),
  );
  locator.registerLazySingletonAsync<CategoryRepository>(
    () async => CategoryRepositoryImpl(
      dataSources: await locator.getAsync<LocalCategoryManagerDataSource>(),
    ),
  );
  locator.registerLazySingletonAsync<AccountRepository>(
    () async => AccountRepositoryImpl(
      dataSource: await locator.getAsync<LocalAccountManagerDataSource>(),
    ),
  );
  locator.registerLazySingletonAsync<DebtRepository>(
    () async => DebtRepositoryImpl(
      dataSource: await locator.getAsync(),
    ),
  );
}

void _setupUseCase() {
  locator.registerLazySingletonAsync(() async =>
      GetExpenseUseCase(expenseRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(() async =>
      DeleteExpenseUseCase(expenseRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(() async =>
      AddExpenseUseCase(expenseRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(() async =>
      GetCategoryUseCase(categoryRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(() async =>
      AddCategoryUseCase(categoryRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(() async =>
      DeleteCategoryUseCase(categoryRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(() async =>
      GetAccountUseCase(accountRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(() async =>
      AddAccountUseCase(accountRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(() async =>
      DeleteAccountUseCase(accountRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(
      () async => DebtUseCase(debtRepository: await locator.getAsync()));
}

void _setupBloc() {
  locator.registerFactory(() => SplashBloc(
        accounts: locator.get(),
        categories: locator.get(),
        service: locator.get(),
        settings: locator.get(),
      ));
  locator.registerFactoryAsync(() async => CategoryBloc(
        getCategoryUseCase: await locator.getAsync(),
        addCategoryUseCase: await locator.getAsync(),
        deleteCategoryUseCase: await locator.getAsync(),
      ));
  locator.registerFactoryAsync(() async => ExpenseBloc(
        accountUseCase: await locator.getAsync(),
        expenseUseCase: await locator.getAsync(),
        addExpenseUseCase: await locator.getAsync(),
        deleteExpenseUseCase: await locator.getAsync(),
      ));
  locator.registerFactoryAsync(() async => AccountsBloc(
        getAccountUseCase: await locator.getAsync(),
        addAccountUseCase: await locator.getAsync(),
        deleteAccountUseCase: await locator.getAsync(),
      ));
  locator.registerFactory(() => HomeBloc(
      locator.get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)));
  locator.registerFactoryAsync(
      () async => DebtsBloc(useCase: await locator.getAsync()));
  locator.registerFactory(() => SummaryCubit());
  locator.registerFactory(() => UserNameImageCubit());
  locator.registerFactory(() => FilterCubit());
  locator.registerFactory(() => FilterDateCubit());
}
