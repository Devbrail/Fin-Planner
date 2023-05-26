// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i5;
import 'package:hive_flutter/hive_flutter.dart' as _i33;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager.dart'
    as _i27;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager_impl.dart'
    as _i28;
import 'package:paisa/src/data/accounts/model/account_model.dart' as _i7;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i42;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i29;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i30;
import 'package:paisa/src/data/category/model/category_model.dart' as _i8;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i48;
import 'package:paisa/src/data/currencies/repository/currencies_repository_impl.dart'
    as _i13;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source.dart'
    as _i14;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source_impl.dart'
    as _i15;
import 'package:paisa/src/data/debt/models/debt_model.dart' as _i9;
import 'package:paisa/src/data/debt/models/transactions_model.dart' as _i10;
import 'package:paisa/src/data/debt/repository/debt_repository_impl.dart'
    as _i17;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager.dart'
    as _i31;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager_impl.dart'
    as _i32;
import 'package:paisa/src/data/expense/model/expense_model.dart' as _i6;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i56;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager.dart'
    as _i34;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager_impl.dart'
    as _i35;
import 'package:paisa/src/data/recurring/model/recurring.dart' as _i11;
import 'package:paisa/src/data/recurring/repository/recurring_repository_impl.dart'
    as _i37;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i21;
import 'package:paisa/src/data/settings/settings.dart' as _i38;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i41;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i70;
import 'package:paisa/src/domain/account/use_case/add_account_use_case.dart'
    as _i43;
import 'package:paisa/src/domain/account/use_case/delete_account_use_case.dart'
    as _i53;
import 'package:paisa/src/domain/account/use_case/get_account_use_case.dart'
    as _i58;
import 'package:paisa/src/domain/account/use_case/get_accounts_use_case.dart'
    as _i59;
import 'package:paisa/src/domain/account/use_case/update_account_use_case.dart'
    as _i72;
import 'package:paisa/src/domain/category/repository/category_repository.dart'
    as _i47;
import 'package:paisa/src/domain/category/use_case/add_category_use_case.dart'
    as _i75;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i71;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i54;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i60;
import 'package:paisa/src/domain/category/use_case/update_category_use_case.dart'
    as _i73;
import 'package:paisa/src/domain/currencies/repository/currencies_repository.dart'
    as _i12;
import 'package:paisa/src/domain/currencies/use_case/get_country_user_case.dart'
    as _i22;
import 'package:paisa/src/domain/currencies/use_case/get_currencies_use_case.dart'
    as _i23;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i16;
import 'package:paisa/src/domain/debt/use_case/add_debt_use.case.dart' as _i44;
import 'package:paisa/src/domain/debt/use_case/add_transaction_use_case.dart'
    as _i46;
import 'package:paisa/src/domain/debt/use_case/debt_use_case.dart' as _i52;
import 'package:paisa/src/domain/debt/use_case/delete_debt_use_case.dart'
    as _i18;
import 'package:paisa/src/domain/debt/use_case/delete_transaction_use_case.dart'
    as _i19;
import 'package:paisa/src/domain/debt/use_case/delete_transactions_use_case.dart'
    as _i20;
import 'package:paisa/src/domain/debt/use_case/get_debt_use_case.dart' as _i24;
import 'package:paisa/src/domain/debt/use_case/get_transactions_use_case.dart'
    as _i25;
import 'package:paisa/src/domain/debt/use_case/update_debt_use.case.dart'
    as _i40;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i55;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i76;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i78;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_account_id.dart'
    as _i79;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_category_id.dart'
    as _i80;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i68;
import 'package:paisa/src/domain/expense/use_case/filter_expense_use_case.dart'
    as _i57;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_account_id.dart'
    as _i62;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_category_id.dart'
    as _i63;
import 'package:paisa/src/domain/expense/use_case/get_expense_use_case.dart'
    as _i61;
import 'package:paisa/src/domain/expense/use_case/get_expenses_use_case.dart'
    as _i64;
import 'package:paisa/src/domain/expense/use_case/update_expense_use_case.dart'
    as _i74;
import 'package:paisa/src/domain/recurring/repository/recurring_repository.dart'
    as _i36;
import 'package:paisa/src/domain/recurring/use_case/add_recurring_use_case.dart'
    as _i45;
import 'package:paisa/src/domain/recurring/use_case/recurring_use_case.dart'
    as _i66;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i82;
import 'package:paisa/src/presentation/biometric/bloc/biometric_bloc.dart'
    as _i4;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i83;
import 'package:paisa/src/presentation/currency_selector/bloc/currency_selector_bloc.dart'
    as _i50;
import 'package:paisa/src/presentation/currency_selector/cubit/country_cubit.dart'
    as _i49;
import 'package:paisa/src/presentation/debits/cubit/debts_bloc.dart' as _i51;
import 'package:paisa/src/presentation/expense/bloc/expense_bloc.dart' as _i81;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i26;
import 'package:paisa/src/presentation/overview/cubit/budget_cubit.dart'
    as _i77;
import 'package:paisa/src/presentation/recurring/cubit/recurring_cubit.dart'
    as _i65;
import 'package:paisa/src/presentation/search/cubit/search_cubit.dart' as _i67;
import 'package:paisa/src/presentation/settings/bloc/settings_controller.dart'
    as _i39;
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart'
    as _i69;

import 'module/hive_module.dart' as _i84;

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
  gh.singleton<_i3.Authenticate>(_i3.Authenticate());
  gh.factory<_i4.BiometricCubit>(
      () => _i4.BiometricCubit(gh<_i3.Authenticate>()));
  await gh.singletonAsync<_i5.Box<_i6.ExpenseModel>>(
    () => hiveBoxModule.expenseBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i5.Box<_i7.AccountModel>>(
    () => hiveBoxModule.accountBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i5.Box<_i8.CategoryModel>>(
    () => hiveBoxModule.categoryBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i5.Box<_i9.DebtModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i5.Box<_i10.TransactionsModel>>(
    () => hiveBoxModule.transactionsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i5.Box<_i11.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i5.Box<dynamic>>(
    () => hiveBoxModule.boxDynamic,
    instanceName: 'settings',
    preResolve: true,
  );
  gh.singleton<_i12.CurrenciesRepository>(
      _i13.CurrencySelectorRepositoryImpl());
  gh.singleton<_i14.DebtLocalDataSource>(_i15.DebtLocalDataSourceImpl(
    debtBox: gh<_i5.Box<_i9.DebtModel>>(),
    transactionsBox: gh<_i5.Box<_i10.TransactionsModel>>(),
  ));
  gh.singleton<_i16.DebtRepository>(
      _i17.DebtRepositoryImpl(dataSource: gh<_i14.DebtLocalDataSource>()));
  gh.singleton<_i18.DeleteDebtUseCase>(
      _i18.DeleteDebtUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i19.DeleteTransactionUseCase>(
      _i19.DeleteTransactionUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i20.DeleteTransactionsUseCase>(_i20.DeleteTransactionsUseCase(
      debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i21.FileHandler>(_i21.FileHandler());
  gh.factory<_i22.GetCountryUseCase>(() =>
      _i22.GetCountryUseCase(repository: gh<_i12.CurrenciesRepository>()));
  gh.factory<_i23.GetCurrenciesUseCase>(() =>
      _i23.GetCurrenciesUseCase(repository: gh<_i12.CurrenciesRepository>()));
  gh.singleton<_i24.GetDebtUseCase>(
      _i24.GetDebtUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i25.GetTransactionsUseCase>(
      _i25.GetTransactionsUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.factory<_i26.HomeBloc>(() => _i26.HomeBloc());
  gh.singleton<_i27.LocalAccountDataManager>(_i28.LocalAccountDataManagerImpl(
      accountBox: gh<_i5.Box<_i7.AccountModel>>()));
  gh.singleton<_i29.LocalCategoryManagerDataSource>(
      _i30.LocalCategoryManagerDataSourceImpl(
          gh<_i5.Box<_i8.CategoryModel>>()));
  gh.factory<_i31.LocalExpenseDataManager>(
      () => _i32.LocalExpenseDataManagerImpl(gh<_i33.Box<_i6.ExpenseModel>>()));
  gh.factory<_i34.LocalRecurringDataManager>(() =>
      _i35.LocalRecurringDataManagerImpl(gh<_i5.Box<_i11.RecurringModel>>()));
  gh.singleton<_i36.RecurringRepository>(_i37.RecurringRepositoryImpl(
    gh<_i34.LocalRecurringDataManager>(),
    gh<_i31.LocalExpenseDataManager>(),
  ));
  gh.singleton<_i38.Settings>(
      _i38.Settings(gh<_i5.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i39.SettingsController>(
      _i39.SettingsController(gh<_i38.Settings>()));
  gh.singleton<_i40.UpdateDebtUseCase>(
      _i40.UpdateDebtUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i41.AccountRepository>(_i42.AccountRepositoryImpl(
      dataSource: gh<_i27.LocalAccountDataManager>()));
  gh.singleton<_i43.AddAccountUseCase>(
      _i43.AddAccountUseCase(accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i44.AddDebtUseCase>(
      _i44.AddDebtUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i45.AddRecurringUseCase>(
      _i45.AddRecurringUseCase(gh<_i36.RecurringRepository>()));
  gh.singleton<_i46.AddTransactionUseCase>(
      _i46.AddTransactionUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i47.CategoryRepository>(_i48.CategoryRepositoryImpl(
    dataSources: gh<_i29.LocalCategoryManagerDataSource>(),
    settings: gh<_i5.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.factory<_i49.CountryCubit>(() => _i49.CountryCubit(
        gh<_i22.GetCountryUseCase>(),
        gh<_i5.Box<dynamic>>(instanceName: 'settings'),
      ));
  gh.factory<_i50.CurrencySelectorBloc>(() => _i50.CurrencySelectorBloc(
        accounts: gh<_i5.Box<_i7.AccountModel>>(),
        categories: gh<_i5.Box<_i8.CategoryModel>>(),
        currenciesUseCase: gh<_i23.GetCurrenciesUseCase>(),
      ));
  gh.factory<_i51.DebtsBloc>(() => _i51.DebtsBloc(
        addDebtUseCase: gh<_i52.AddDebtUseCase>(),
        getDebtUseCase: gh<_i52.GetDebtUseCase>(),
        getTransactionsUseCase: gh<_i52.GetTransactionsUseCase>(),
        addTransactionUseCase: gh<_i52.AddTransactionUseCase>(),
        updateDebtUseCase: gh<_i52.UpdateDebtUseCase>(),
        deleteDebtUseCase: gh<_i52.DeleteDebtUseCase>(),
        deleteTransactionsUseCase: gh<_i52.DeleteTransactionsUseCase>(),
        deleteTransactionUseCase: gh<_i52.DeleteTransactionUseCase>(),
      ));
  gh.singleton<_i53.DeleteAccountUseCase>(_i53.DeleteAccountUseCase(
      accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i54.DeleteCategoryUseCase>(_i54.DeleteCategoryUseCase(
      categoryRepository: gh<_i47.CategoryRepository>()));
  gh.singleton<_i55.ExpenseRepository>(_i56.ExpenseRepositoryImpl(
      dataSource: gh<_i31.LocalExpenseDataManager>()));
  gh.singleton<_i57.FilterExpenseUseCase>(
      _i57.FilterExpenseUseCase(gh<_i55.ExpenseRepository>()));
  gh.singleton<_i58.GetAccountUseCase>(
      _i58.GetAccountUseCase(accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i59.GetAccountsUseCase>(
      _i59.GetAccountsUseCase(accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i60.GetCategoryUseCase>(_i60.GetCategoryUseCase(
      categoryRepository: gh<_i47.CategoryRepository>()));
  gh.singleton<_i61.GetExpenseUseCase>(
      _i61.GetExpenseUseCase(expenseRepository: gh<_i55.ExpenseRepository>()));
  gh.singleton<_i62.GetExpensesFromAccountIdUseCase>(
      _i62.GetExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i55.ExpenseRepository>()));
  gh.singleton<_i63.GetExpensesFromCategoryIdUseCase>(
      _i63.GetExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i55.ExpenseRepository>()));
  gh.singleton<_i64.GetExpensesUseCase>(
      _i64.GetExpensesUseCase(expenseRepository: gh<_i55.ExpenseRepository>()));
  gh.factory<_i65.RecurringCubit>(
      () => _i65.RecurringCubit(gh<_i66.AddRecurringUseCase>()));
  gh.factory<_i67.SearchCubit>(
      () => _i67.SearchCubit(gh<_i68.FilterExpenseUseCase>()));
  gh.singleton<_i69.SummaryController>(_i69.SummaryController(
    getAccountUseCase: gh<_i70.GetAccountUseCase>(),
    getCategoryUseCase: gh<_i71.GetCategoryUseCase>(),
    getExpensesFromCategoryIdUseCase:
        gh<_i68.GetExpensesFromCategoryIdUseCase>(),
  ));
  gh.singleton<_i72.UpdateAccountUseCase>(_i72.UpdateAccountUseCase(
      accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i73.UpdateCategoryUseCase>(_i73.UpdateCategoryUseCase(
      categoryRepository: gh<_i47.CategoryRepository>()));
  gh.singleton<_i74.UpdateExpensesUseCase>(_i74.UpdateExpensesUseCase(
      expenseRepository: gh<_i55.ExpenseRepository>()));
  gh.singleton<_i75.AddCategoryUseCase>(_i75.AddCategoryUseCase(
      categoryRepository: gh<_i47.CategoryRepository>()));
  gh.singleton<_i76.AddExpenseUseCase>(
      _i76.AddExpenseUseCase(expenseRepository: gh<_i55.ExpenseRepository>()));
  gh.factory<_i77.BudgetCubit>(() => _i77.BudgetCubit(
        gh<_i68.GetExpensesUseCase>(),
        gh<_i69.SummaryController>(),
      ));
  gh.singleton<_i78.DeleteExpenseUseCase>(_i78.DeleteExpenseUseCase(
      expenseRepository: gh<_i55.ExpenseRepository>()));
  gh.singleton<_i79.DeleteExpensesFromAccountIdUseCase>(
      _i79.DeleteExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i55.ExpenseRepository>()));
  gh.singleton<_i80.DeleteExpensesFromCategoryIdUseCase>(
      _i80.DeleteExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i55.ExpenseRepository>()));
  gh.factory<_i81.ExpenseBloc>(() => _i81.ExpenseBloc(
        gh<_i39.SettingsController>(),
        expenseUseCase: gh<_i68.GetExpenseUseCase>(),
        accountUseCase: gh<_i70.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i68.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i68.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i74.UpdateExpensesUseCase>(),
        accountsUseCase: gh<_i70.GetAccountsUseCase>(),
      ));
  gh.factory<_i82.AccountsBloc>(() => _i82.AccountsBloc(
        getAccountUseCase: gh<_i70.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i70.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i68.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i70.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i70.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i71.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i68.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i70.UpdateAccountUseCase>(),
      ));
  gh.factory<_i83.CategoryBloc>(() => _i83.CategoryBloc(
        getCategoryUseCase: gh<_i71.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i71.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i71.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i68.DeleteExpensesFromCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i71.UpdateCategoryUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i84.HiveBoxModule {}
