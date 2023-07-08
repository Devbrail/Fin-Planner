// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i22;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i25;
import 'package:in_app_review/in_app_review.dart' as _i36;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/app/in_app.dart' as _i73;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager.dart'
    as _i47;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager_impl.dart'
    as _i48;
import 'package:paisa/src/data/accounts/model/account_model.dart' as _i7;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i50;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i11;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i12;
import 'package:paisa/src/data/category/model/category_model.dart' as _i8;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i57;
import 'package:paisa/src/data/currencies/repository/currencies_repository_impl.dart'
    as _i14;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source.dart'
    as _i15;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source_impl.dart'
    as _i16;
import 'package:paisa/src/data/debt/models/debt_model.dart' as _i9;
import 'package:paisa/src/data/debt/models/transactions_model.dart' as _i10;
import 'package:paisa/src/data/debt/repository/debt_repository_impl.dart'
    as _i18;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager.dart'
    as _i23;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager_impl.dart'
    as _i24;
import 'package:paisa/src/data/expense/model/expense_model.dart' as _i6;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i27;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager.dart'
    as _i37;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager_impl.dart'
    as _i38;
import 'package:paisa/src/data/recurring/model/recurring.dart' as _i5;
import 'package:paisa/src/data/recurring/repository/recurring_repository_impl.dart'
    as _i40;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i66;
import 'package:paisa/src/data/settings/settings.dart' as _i43;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i49;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i78;
import 'package:paisa/src/domain/account/use_case/add_account_use_case.dart'
    as _i51;
import 'package:paisa/src/domain/account/use_case/delete_account_use_case.dart'
    as _i61;
import 'package:paisa/src/domain/account/use_case/get_account_use_case.dart'
    as _i67;
import 'package:paisa/src/domain/account/use_case/get_accounts_use_case.dart'
    as _i68;
import 'package:paisa/src/domain/account/use_case/update_account_use_case.dart'
    as _i80;
import 'package:paisa/src/domain/category/repository/category_repository.dart'
    as _i56;
import 'package:paisa/src/domain/category/use_case/add_category_use_case.dart'
    as _i83;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i72;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i62;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i69;
import 'package:paisa/src/domain/category/use_case/get_default_categories_use_case.dart'
    as _i70;
import 'package:paisa/src/domain/category/use_case/update_category_use_case.dart'
    as _i81;
import 'package:paisa/src/domain/currencies/repository/currencies_repository.dart'
    as _i13;
import 'package:paisa/src/domain/currencies/use_case/get_countries_user_case.dart'
    as _i29;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i17;
import 'package:paisa/src/domain/debt/use_case/add_debt_use.case.dart' as _i52;
import 'package:paisa/src/domain/debt/use_case/add_transaction_use_case.dart'
    as _i55;
import 'package:paisa/src/domain/debt/use_case/debt_use_case.dart' as _i60;
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
    as _i45;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i26;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i53;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i63;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_account_id.dart'
    as _i64;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_category_id.dart'
    as _i65;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i42;
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
    as _i46;
import 'package:paisa/src/domain/recurring/repository/recurring_repository.dart'
    as _i39;
import 'package:paisa/src/domain/recurring/use_case/add_recurring_use_case.dart'
    as _i54;
import 'package:paisa/src/domain/recurring/use_case/recurring_use_case.dart'
    as _i75;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i82;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i85;
import 'package:paisa/src/presentation/currency_selector/cubit/country_cubit.dart'
    as _i58;
import 'package:paisa/src/presentation/debits/cubit/debts_bloc.dart' as _i59;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i71;
import 'package:paisa/src/presentation/overview/cubit/budget_cubit.dart'
    as _i84;
import 'package:paisa/src/presentation/recurring/cubit/recurring_cubit.dart'
    as _i74;
import 'package:paisa/src/presentation/search/cubit/search_cubit.dart' as _i41;
import 'package:paisa/src/presentation/settings/controller/settings_controller.dart'
    as _i44;
import 'package:paisa/src/presentation/settings/cubit/settings_cubit.dart'
    as _i76;
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart'
    as _i77;
import 'package:paisa/src/presentation/transaction/bloc/transaction_bloc.dart'
    as _i79;

import 'module/hive_module.dart' as _i86;
import 'module/service_module.dart' as _i87;

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
  await gh.singletonAsync<_i4.Box<dynamic>>(
    () => hiveBoxModule.boxDynamic,
    instanceName: 'settings',
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i5.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i6.ExpenseModel>>(
    () => hiveBoxModule.expenseBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i7.AccountModel>>(
    () => hiveBoxModule.accountBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i8.CategoryModel>>(
    () => hiveBoxModule.categoryBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i9.DebtModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i10.TransactionsModel>>(
    () => hiveBoxModule.transactionsBox,
    preResolve: true,
  );
  gh.singleton<_i11.CategoryLocalDataManager>(
      _i12.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i8.CategoryModel>>()));
  gh.singleton<_i13.CurrenciesRepository>(
      _i14.CurrencySelectorRepositoryImpl());
  gh.singleton<_i15.DebtLocalDataSource>(_i16.DebtLocalDataSourceImpl(
    debtBox: gh<_i4.Box<_i9.DebtModel>>(),
    transactionsBox: gh<_i4.Box<_i10.TransactionsModel>>(),
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
      () => _i24.LocalExpenseDataManagerImpl(gh<_i25.Box<_i6.ExpenseModel>>()));
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
  gh.singleton<_i36.InAppReview>(serviceBoxModule.providesInAppReview());
  gh.factory<_i37.LocalRecurringDataManager>(() =>
      _i38.LocalRecurringDataManagerImpl(gh<_i4.Box<_i5.RecurringModel>>()));
  gh.singleton<_i39.RecurringRepository>(_i40.RecurringRepositoryImpl(
    gh<_i37.LocalRecurringDataManager>(),
    gh<_i23.ExpenseLocalDataManager>(),
  ));
  gh.factory<_i41.SearchCubit>(
      () => _i41.SearchCubit(gh<_i42.FilterExpenseUseCase>()));
  gh.singleton<_i43.Settings>(
      _i43.Settings(gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i44.SettingsController>(
      _i44.SettingsController(gh<_i43.Settings>()));
  gh.singleton<_i45.UpdateDebtUseCase>(
      _i45.UpdateDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i46.UpdateExpensesUseCase>(_i46.UpdateExpensesUseCase(
      expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i47.AccountLocalDataManager>(_i48.LocalAccountDataManagerImpl(
      accountBox: gh<_i4.Box<_i7.AccountModel>>()));
  gh.singleton<_i49.AccountRepository>(_i50.AccountRepositoryImpl(
      dataSource: gh<_i47.AccountLocalDataManager>()));
  gh.singleton<_i51.AddAccountUseCase>(
      _i51.AddAccountUseCase(accountRepository: gh<_i49.AccountRepository>()));
  gh.singleton<_i52.AddDebtUseCase>(
      _i52.AddDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i53.AddExpenseUseCase>(
      _i53.AddExpenseUseCase(expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i54.AddRecurringUseCase>(
      _i54.AddRecurringUseCase(gh<_i39.RecurringRepository>()));
  gh.singleton<_i55.AddTransactionUseCase>(
      _i55.AddTransactionUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i56.CategoryRepository>(_i57.CategoryRepositoryImpl(
    dataSources: gh<_i11.CategoryLocalDataManager>(),
    expenseDataManager: gh<_i23.ExpenseLocalDataManager>(),
    settings: gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.factory<_i58.CountryCubit>(() => _i58.CountryCubit(
        gh<_i29.GetCountriesUseCase>(),
        gh<_i44.SettingsController>(),
      ));
  gh.factory<_i59.DebtsBloc>(() => _i59.DebtsBloc(
        addDebtUseCase: gh<_i60.AddDebtUseCase>(),
        getDebtUseCase: gh<_i60.GetDebtUseCase>(),
        getTransactionsUseCase: gh<_i60.GetTransactionsUseCase>(),
        addTransactionUseCase: gh<_i60.AddTransactionUseCase>(),
        updateDebtUseCase: gh<_i60.UpdateDebtUseCase>(),
        deleteDebtUseCase: gh<_i60.DeleteDebtUseCase>(),
        deleteTransactionsUseCase: gh<_i60.DeleteTransactionsUseCase>(),
        deleteTransactionUseCase: gh<_i60.DeleteTransactionUseCase>(),
      ));
  gh.singleton<_i61.DeleteAccountUseCase>(_i61.DeleteAccountUseCase(
      accountRepository: gh<_i49.AccountRepository>()));
  gh.singleton<_i62.DeleteCategoryUseCase>(_i62.DeleteCategoryUseCase(
      categoryRepository: gh<_i56.CategoryRepository>()));
  gh.singleton<_i63.DeleteExpenseUseCase>(_i63.DeleteExpenseUseCase(
      expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i64.DeleteExpensesFromAccountIdUseCase>(
      _i64.DeleteExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i65.DeleteExpensesFromCategoryIdUseCase>(
      _i65.DeleteExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i66.FileHandler>(_i66.FileHandler(
    gh<_i22.DeviceInfoPlugin>(),
    gh<_i47.AccountLocalDataManager>(),
    gh<_i11.CategoryLocalDataManager>(),
    gh<_i23.ExpenseLocalDataManager>(),
  ));
  gh.singleton<_i67.GetAccountUseCase>(
      _i67.GetAccountUseCase(accountRepository: gh<_i49.AccountRepository>()));
  gh.singleton<_i68.GetAccountsUseCase>(
      _i68.GetAccountsUseCase(accountRepository: gh<_i49.AccountRepository>()));
  gh.singleton<_i69.GetCategoryUseCase>(_i69.GetCategoryUseCase(
      categoryRepository: gh<_i56.CategoryRepository>()));
  gh.singleton<_i70.GetDefaultCategoriesUseCase>(
      _i70.GetDefaultCategoriesUseCase(
          categoryRepository: gh<_i56.CategoryRepository>()));
  gh.factory<_i71.HomeBloc>(() => _i71.HomeBloc(
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
        gh<_i42.GetExpensesUseCase>(),
        gh<_i72.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i73.InApp>(_i73.InApp(gh<_i36.InAppReview>()));
  gh.factory<_i74.RecurringCubit>(
      () => _i74.RecurringCubit(gh<_i75.AddRecurringUseCase>()));
  gh.factory<_i76.SettingCubit>(() => _i76.SettingCubit(
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
        gh<_i42.GetExpensesUseCase>(),
        gh<_i72.GetDefaultCategoriesUseCase>(),
        gh<_i46.UpdateExpensesUseCase>(),
        gh<_i66.FileHandler>(),
      ));
  gh.singleton<_i77.SummaryController>(_i77.SummaryController(
    getAccountUseCase: gh<_i78.GetAccountUseCase>(),
    getCategoryUseCase: gh<_i72.GetCategoryUseCase>(),
    getExpensesFromCategoryIdUseCase:
        gh<_i42.GetExpensesFromCategoryIdUseCase>(),
  ));
  gh.factory<_i79.TransactionBloc>(() => _i79.TransactionBloc(
        gh<_i44.SettingsController>(),
        expenseUseCase: gh<_i42.GetExpenseUseCase>(),
        accountUseCase: gh<_i78.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i42.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i42.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i46.UpdateExpensesUseCase>(),
        accountsUseCase: gh<_i78.GetAccountsUseCase>(),
        defaultCategoriesUseCase: gh<_i72.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i80.UpdateAccountUseCase>(_i80.UpdateAccountUseCase(
      accountRepository: gh<_i49.AccountRepository>()));
  gh.singleton<_i81.UpdateCategoryUseCase>(_i81.UpdateCategoryUseCase(
      categoryRepository: gh<_i56.CategoryRepository>()));
  gh.factory<_i82.AccountsBloc>(() => _i82.AccountsBloc(
        getAccountUseCase: gh<_i78.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i78.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i42.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i78.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i78.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i72.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i42.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i78.UpdateAccountUseCase>(),
      ));
  gh.singleton<_i83.AddCategoryUseCase>(_i83.AddCategoryUseCase(
      categoryRepository: gh<_i56.CategoryRepository>()));
  gh.factory<_i84.BudgetCubit>(() => _i84.BudgetCubit(
        gh<_i42.GetExpensesUseCase>(),
        gh<_i72.GetCategoryUseCase>(),
        gh<_i72.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i85.CategoryBloc>(() => _i85.CategoryBloc(
        getCategoryUseCase: gh<_i72.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i72.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i72.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i42.DeleteExpensesFromCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i72.UpdateCategoryUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i86.HiveBoxModule {}

class _$ServiceBoxModule extends _i87.ServiceBoxModule {}
