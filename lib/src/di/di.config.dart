// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i22;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i25;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager.dart'
    as _i46;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager_impl.dart'
    as _i47;
import 'package:paisa/src/data/accounts/model/account_model.dart' as _i8;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i49;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i11;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i12;
import 'package:paisa/src/data/category/model/category_model.dart' as _i9;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i56;
import 'package:paisa/src/data/currencies/repository/currencies_repository_impl.dart'
    as _i14;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source.dart'
    as _i15;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source_impl.dart'
    as _i16;
import 'package:paisa/src/data/debt/models/debt_model.dart' as _i10;
import 'package:paisa/src/data/debt/models/transactions_model.dart' as _i5;
import 'package:paisa/src/data/debt/repository/debt_repository_impl.dart'
    as _i18;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager.dart'
    as _i23;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager_impl.dart'
    as _i24;
import 'package:paisa/src/data/expense/model/expense_model.dart' as _i7;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i27;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager.dart'
    as _i36;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager_impl.dart'
    as _i37;
import 'package:paisa/src/data/recurring/model/recurring.dart' as _i6;
import 'package:paisa/src/data/recurring/repository/recurring_repository_impl.dart'
    as _i39;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i65;
import 'package:paisa/src/data/settings/settings.dart' as _i42;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i48;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i76;
import 'package:paisa/src/domain/account/use_case/add_account_use_case.dart'
    as _i50;
import 'package:paisa/src/domain/account/use_case/delete_account_use_case.dart'
    as _i60;
import 'package:paisa/src/domain/account/use_case/get_account_use_case.dart'
    as _i66;
import 'package:paisa/src/domain/account/use_case/get_accounts_use_case.dart'
    as _i67;
import 'package:paisa/src/domain/account/use_case/update_account_use_case.dart'
    as _i78;
import 'package:paisa/src/domain/category/repository/category_repository.dart'
    as _i55;
import 'package:paisa/src/domain/category/use_case/add_category_use_case.dart'
    as _i81;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i71;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i61;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i68;
import 'package:paisa/src/domain/category/use_case/get_default_categories_use_case.dart'
    as _i69;
import 'package:paisa/src/domain/category/use_case/update_category_use_case.dart'
    as _i79;
import 'package:paisa/src/domain/currencies/repository/currencies_repository.dart'
    as _i13;
import 'package:paisa/src/domain/currencies/use_case/get_countries_user_case.dart'
    as _i29;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i17;
import 'package:paisa/src/domain/debt/use_case/add_debt_use.case.dart' as _i51;
import 'package:paisa/src/domain/debt/use_case/add_transaction_use_case.dart'
    as _i54;
import 'package:paisa/src/domain/debt/use_case/debt_use_case.dart' as _i59;
import 'package:paisa/src/domain/debt/use_case/delete_debt_use_case.dart'
    as _i19;
import 'package:paisa/src/domain/debt/use_case/delete_transaction_use_case.dart'
    as _i20;
import 'package:paisa/src/domain/debt/use_case/delete_transactions_use_case.dart'
    as _i21;
import 'package:paisa/src/domain/debt/use_case/get_debt_use_case.dart' as _i30;
import 'package:paisa/src/domain/debt/use_case/get_transactions_use_case.dart'
    as _i35;
import 'package:paisa/src/domain/debt/use_case/update_debt_use.case.dart'
    as _i44;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i26;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i52;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i62;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_account_id.dart'
    as _i63;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_category_id.dart'
    as _i64;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i41;
import 'package:paisa/src/domain/expense/use_case/filter_expense_use_case.dart'
    as _i28;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_account_id.dart'
    as _i32;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_category_id.dart'
    as _i33;
import 'package:paisa/src/domain/expense/use_case/get_expense_use_case.dart'
    as _i31;
import 'package:paisa/src/domain/expense/use_case/get_expenses_use_case.dart'
    as _i34;
import 'package:paisa/src/domain/expense/use_case/update_expense_use_case.dart'
    as _i45;
import 'package:paisa/src/domain/recurring/repository/recurring_repository.dart'
    as _i38;
import 'package:paisa/src/domain/recurring/use_case/add_recurring_use_case.dart'
    as _i53;
import 'package:paisa/src/domain/recurring/use_case/recurring_use_case.dart'
    as _i73;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i80;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i83;
import 'package:paisa/src/presentation/currency_selector/cubit/country_cubit.dart'
    as _i57;
import 'package:paisa/src/presentation/debits/cubit/debts_bloc.dart' as _i58;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i70;
import 'package:paisa/src/presentation/overview/cubit/budget_cubit.dart'
    as _i82;
import 'package:paisa/src/presentation/recurring/cubit/recurring_cubit.dart'
    as _i72;
import 'package:paisa/src/presentation/search/cubit/search_cubit.dart' as _i40;
import 'package:paisa/src/presentation/settings/controller/settings_controller.dart'
    as _i43;
import 'package:paisa/src/presentation/settings/cubit/settings_cubit.dart'
    as _i74;
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart'
    as _i75;
import 'package:paisa/src/presentation/transaction/bloc/transaction_bloc.dart'
    as _i77;

import 'module/hive_module.dart' as _i84;
import 'module/service_module.dart' as _i85;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final hiveBoxModule = _$HiveBoxModule();
  final serviceBoxModule = _$ServiceBoxModule();
  gh.singleton<_i3.Authenticate>(_i3.Authenticate());
  await gh.singletonAsync<_i4.Box<_i5.TransactionsModel>>(
    () => hiveBoxModule.transactionsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i6.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<dynamic>>(
    () => hiveBoxModule.boxDynamic,
    instanceName: 'settings',
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i7.ExpenseModel>>(
    () => hiveBoxModule.expenseBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i8.AccountModel>>(
    () => hiveBoxModule.accountBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i9.CategoryModel>>(
    () => hiveBoxModule.categoryBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i10.DebtModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  gh.singleton<_i11.CategoryLocalDataManager>(
      _i12.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i9.CategoryModel>>()));
  gh.singleton<_i13.CurrenciesRepository>(
      _i14.CurrencySelectorRepositoryImpl());
  gh.singleton<_i15.DebtLocalDataSource>(_i16.DebtLocalDataSourceImpl(
    debtBox: gh<_i4.Box<_i10.DebtModel>>(),
    transactionsBox: gh<_i4.Box<_i5.TransactionsModel>>(),
  ));
  gh.singleton<_i17.DebtRepository>(
      _i18.DebtRepositoryImpl(dataSource: gh<_i15.DebtLocalDataSource>()));
  gh.singleton<_i19.DeleteDebtUseCase>(
      _i19.DeleteDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i20.DeleteTransactionUseCase>(
      _i20.DeleteTransactionUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i21.DeleteTransactionsUseCase>(_i21.DeleteTransactionsUseCase(
      debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i22.DeviceInfoPlugin>(
      serviceBoxModule.providesDeviceInfoPlugin());
  gh.factory<_i23.ExpenseLocalDataManager>(
      () => _i24.LocalExpenseDataManagerImpl(gh<_i25.Box<_i7.ExpenseModel>>()));
  gh.singleton<_i26.ExpenseRepository>(_i27.ExpenseRepositoryImpl(
      dataSource: gh<_i23.ExpenseLocalDataManager>()));
  gh.singleton<_i28.FilterExpenseUseCase>(
      _i28.FilterExpenseUseCase(gh<_i26.ExpenseRepository>()));
  gh.factory<_i29.GetCountriesUseCase>(() =>
      _i29.GetCountriesUseCase(repository: gh<_i13.CurrenciesRepository>()));
  gh.singleton<_i30.GetDebtUseCase>(
      _i30.GetDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i31.GetExpenseUseCase>(
      _i31.GetExpenseUseCase(expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i32.GetExpensesFromAccountIdUseCase>(
      _i32.GetExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i33.GetExpensesFromCategoryIdUseCase>(
      _i33.GetExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i34.GetExpensesUseCase>(
      _i34.GetExpensesUseCase(expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i35.GetTransactionsUseCase>(
      _i35.GetTransactionsUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.factory<_i36.LocalRecurringDataManager>(() =>
      _i37.LocalRecurringDataManagerImpl(gh<_i4.Box<_i6.RecurringModel>>()));
  gh.singleton<_i38.RecurringRepository>(_i39.RecurringRepositoryImpl(
    gh<_i36.LocalRecurringDataManager>(),
    gh<_i23.ExpenseLocalDataManager>(),
  ));
  gh.factory<_i40.SearchCubit>(
      () => _i40.SearchCubit(gh<_i41.FilterExpenseUseCase>()));
  gh.singleton<_i42.Settings>(
      _i42.Settings(gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i43.SettingsController>(
      _i43.SettingsController(gh<_i42.Settings>()));
  gh.singleton<_i44.UpdateDebtUseCase>(
      _i44.UpdateDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i45.UpdateExpensesUseCase>(_i45.UpdateExpensesUseCase(
      expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i46.AccountLocalDataManager>(_i47.LocalAccountDataManagerImpl(
      accountBox: gh<_i4.Box<_i8.AccountModel>>()));
  gh.singleton<_i48.AccountRepository>(_i49.AccountRepositoryImpl(
      dataSource: gh<_i46.AccountLocalDataManager>()));
  gh.singleton<_i50.AddAccountUseCase>(
      _i50.AddAccountUseCase(accountRepository: gh<_i48.AccountRepository>()));
  gh.singleton<_i51.AddDebtUseCase>(
      _i51.AddDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i52.AddExpenseUseCase>(
      _i52.AddExpenseUseCase(expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i53.AddRecurringUseCase>(
      _i53.AddRecurringUseCase(gh<_i38.RecurringRepository>()));
  gh.singleton<_i54.AddTransactionUseCase>(
      _i54.AddTransactionUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i55.CategoryRepository>(_i56.CategoryRepositoryImpl(
    dataSources: gh<_i11.CategoryLocalDataManager>(),
    expenseDataManager: gh<_i23.ExpenseLocalDataManager>(),
    settings: gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.factory<_i57.CountryCubit>(() => _i57.CountryCubit(
        gh<_i29.GetCountriesUseCase>(),
        gh<_i43.SettingsController>(),
      ));
  gh.factory<_i58.DebtsBloc>(() => _i58.DebtsBloc(
        addDebtUseCase: gh<_i59.AddDebtUseCase>(),
        getDebtUseCase: gh<_i59.GetDebtUseCase>(),
        getTransactionsUseCase: gh<_i59.GetTransactionsUseCase>(),
        addTransactionUseCase: gh<_i59.AddTransactionUseCase>(),
        updateDebtUseCase: gh<_i59.UpdateDebtUseCase>(),
        deleteDebtUseCase: gh<_i59.DeleteDebtUseCase>(),
        deleteTransactionsUseCase: gh<_i59.DeleteTransactionsUseCase>(),
        deleteTransactionUseCase: gh<_i59.DeleteTransactionUseCase>(),
      ));
  gh.singleton<_i60.DeleteAccountUseCase>(_i60.DeleteAccountUseCase(
      accountRepository: gh<_i48.AccountRepository>()));
  gh.singleton<_i61.DeleteCategoryUseCase>(_i61.DeleteCategoryUseCase(
      categoryRepository: gh<_i55.CategoryRepository>()));
  gh.singleton<_i62.DeleteExpenseUseCase>(_i62.DeleteExpenseUseCase(
      expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i63.DeleteExpensesFromAccountIdUseCase>(
      _i63.DeleteExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i64.DeleteExpensesFromCategoryIdUseCase>(
      _i64.DeleteExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i65.FileHandler>(_i65.FileHandler(
    gh<_i22.DeviceInfoPlugin>(),
    gh<_i46.AccountLocalDataManager>(),
    gh<_i11.CategoryLocalDataManager>(),
    gh<_i23.ExpenseLocalDataManager>(),
  ));
  gh.singleton<_i66.GetAccountUseCase>(
      _i66.GetAccountUseCase(accountRepository: gh<_i48.AccountRepository>()));
  gh.singleton<_i67.GetAccountsUseCase>(
      _i67.GetAccountsUseCase(accountRepository: gh<_i48.AccountRepository>()));
  gh.singleton<_i68.GetCategoryUseCase>(_i68.GetCategoryUseCase(
      categoryRepository: gh<_i55.CategoryRepository>()));
  gh.singleton<_i69.GetDefaultCategoriesUseCase>(
      _i69.GetDefaultCategoriesUseCase(
          categoryRepository: gh<_i55.CategoryRepository>()));
  gh.factory<_i70.HomeBloc>(() => _i70.HomeBloc(
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
        gh<_i41.GetExpensesUseCase>(),
        gh<_i71.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i72.RecurringCubit>(
      () => _i72.RecurringCubit(gh<_i73.AddRecurringUseCase>()));
  gh.factory<_i74.SettingCubit>(() => _i74.SettingCubit(
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
        gh<_i41.GetExpensesUseCase>(),
        gh<_i71.GetDefaultCategoriesUseCase>(),
        gh<_i45.UpdateExpensesUseCase>(),
        gh<_i65.FileHandler>(),
      ));
  gh.singleton<_i75.SummaryController>(_i75.SummaryController(
    getAccountUseCase: gh<_i76.GetAccountUseCase>(),
    getCategoryUseCase: gh<_i71.GetCategoryUseCase>(),
    getExpensesFromCategoryIdUseCase:
        gh<_i41.GetExpensesFromCategoryIdUseCase>(),
  ));
  gh.factory<_i77.TransactionBloc>(() => _i77.TransactionBloc(
        gh<_i43.SettingsController>(),
        expenseUseCase: gh<_i41.GetExpenseUseCase>(),
        accountUseCase: gh<_i76.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i41.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i41.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i45.UpdateExpensesUseCase>(),
        accountsUseCase: gh<_i76.GetAccountsUseCase>(),
        defaultCategoriesUseCase: gh<_i71.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i78.UpdateAccountUseCase>(_i78.UpdateAccountUseCase(
      accountRepository: gh<_i48.AccountRepository>()));
  gh.singleton<_i79.UpdateCategoryUseCase>(_i79.UpdateCategoryUseCase(
      categoryRepository: gh<_i55.CategoryRepository>()));
  gh.factory<_i80.AccountsBloc>(() => _i80.AccountsBloc(
        getAccountUseCase: gh<_i76.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i76.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i41.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i76.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i76.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i71.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i41.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i76.UpdateAccountUseCase>(),
      ));
  gh.singleton<_i81.AddCategoryUseCase>(_i81.AddCategoryUseCase(
      categoryRepository: gh<_i55.CategoryRepository>()));
  gh.factory<_i82.BudgetCubit>(() => _i82.BudgetCubit(
        gh<_i41.GetExpensesUseCase>(),
        gh<_i71.GetCategoryUseCase>(),
        gh<_i71.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i83.CategoryBloc>(() => _i83.CategoryBloc(
        getCategoryUseCase: gh<_i71.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i71.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i71.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i41.DeleteExpensesFromCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i71.UpdateCategoryUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i84.HiveBoxModule {}

class _$ServiceBoxModule extends _i85.ServiceBoxModule {}
