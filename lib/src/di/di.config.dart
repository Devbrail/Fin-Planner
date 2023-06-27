// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i30;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/data/accounts/data_sources/account_local_data_source.dart'
    as _i38;
import 'package:paisa/src/data/accounts/model/account_model.dart' as _i7;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i40;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i26;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i27;
import 'package:paisa/src/data/category/model/category_model.dart' as _i8;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i46;
import 'package:paisa/src/data/currencies/repository/currencies_repository_impl.dart'
    as _i12;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source.dart'
    as _i14;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source_impl.dart'
    as _i15;
import 'package:paisa/src/data/debt/models/debt_model.dart' as _i9;
import 'package:paisa/src/data/debt/models/transactions_model.dart' as _i10;
import 'package:paisa/src/data/debt/repository/debt_repository_impl.dart'
    as _i17;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager.dart'
    as _i28;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager_impl.dart'
    as _i29;
import 'package:paisa/src/data/expense/model/expense_model.dart' as _i6;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i53;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager.dart'
    as _i31;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager_impl.dart'
    as _i32;
import 'package:paisa/src/data/recurring/model/recurring.dart' as _i5;
import 'package:paisa/src/data/recurring/repository/recurring_repository_impl.dart'
    as _i34;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i21;
import 'package:paisa/src/data/settings/settings.dart' as _i35;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i39;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i67;
import 'package:paisa/src/domain/account/use_case/add_account_use_case.dart'
    as _i41;
import 'package:paisa/src/domain/account/use_case/delete_account_use_case.dart'
    as _i50;
import 'package:paisa/src/domain/account/use_case/get_account_use_case.dart'
    as _i55;
import 'package:paisa/src/domain/account/use_case/get_accounts_use_case.dart'
    as _i56;
import 'package:paisa/src/domain/account/use_case/update_account_use_case.dart'
    as _i69;
import 'package:paisa/src/domain/category/repository/category_repository.dart'
    as _i45;
import 'package:paisa/src/domain/category/use_case/add_category_use_case.dart'
    as _i72;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i68;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i51;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i57;
import 'package:paisa/src/domain/category/use_case/update_category_use_case.dart'
    as _i70;
import 'package:paisa/src/domain/currencies/repository/currencies_repository.dart'
    as _i11;
import 'package:paisa/src/domain/currencies/use_case/get_country_user_case.dart'
    as _i22;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i16;
import 'package:paisa/src/domain/debt/use_case/add_debt_use.case.dart' as _i42;
import 'package:paisa/src/domain/debt/use_case/add_transaction_use_case.dart'
    as _i44;
import 'package:paisa/src/domain/debt/use_case/debt_use_case.dart' as _i49;
import 'package:paisa/src/domain/debt/use_case/delete_debt_use_case.dart'
    as _i18;
import 'package:paisa/src/domain/debt/use_case/delete_transaction_use_case.dart'
    as _i19;
import 'package:paisa/src/domain/debt/use_case/delete_transactions_use_case.dart'
    as _i20;
import 'package:paisa/src/domain/debt/use_case/get_debt_use_case.dart' as _i23;
import 'package:paisa/src/domain/debt/use_case/get_transactions_use_case.dart'
    as _i24;
import 'package:paisa/src/domain/debt/use_case/update_debt_use.case.dart'
    as _i37;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i52;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i73;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i75;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_account_id.dart'
    as _i76;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_category_id.dart'
    as _i77;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i65;
import 'package:paisa/src/domain/expense/use_case/filter_expense_use_case.dart'
    as _i54;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_account_id.dart'
    as _i59;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_category_id.dart'
    as _i60;
import 'package:paisa/src/domain/expense/use_case/get_expense_use_case.dart'
    as _i58;
import 'package:paisa/src/domain/expense/use_case/get_expenses_use_case.dart'
    as _i61;
import 'package:paisa/src/domain/expense/use_case/update_expense_use_case.dart'
    as _i71;
import 'package:paisa/src/domain/recurring/repository/recurring_repository.dart'
    as _i33;
import 'package:paisa/src/domain/recurring/use_case/add_recurring_use_case.dart'
    as _i43;
import 'package:paisa/src/domain/recurring/use_case/recurring_use_case.dart'
    as _i63;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i79;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i80;
import 'package:paisa/src/presentation/currency_selector/cubit/country_cubit.dart'
    as _i47;
import 'package:paisa/src/presentation/debits/cubit/debts_bloc.dart' as _i48;
import 'package:paisa/src/presentation/expense/bloc/expense_bloc.dart' as _i78;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i25;
import 'package:paisa/src/presentation/overview/cubit/budget_cubit.dart'
    as _i74;
import 'package:paisa/src/presentation/recurring/cubit/recurring_cubit.dart'
    as _i62;
import 'package:paisa/src/presentation/search/cubit/search_cubit.dart' as _i64;
import 'package:paisa/src/presentation/settings/bloc/settings_controller.dart'
    as _i36;
import 'package:paisa/src/presentation/settings/cubit/data_cubit.dart' as _i13;
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart'
    as _i66;

import 'module/hive_module.dart' as _i81;

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
  gh.singleton<_i11.CurrenciesRepository>(
      _i12.CurrencySelectorRepositoryImpl());
  gh.factory<_i13.DataCubit>(() => _i13.DataCubit());
  gh.singleton<_i14.DebtLocalDataSource>(_i15.DebtLocalDataSourceImpl(
    debtBox: gh<_i4.Box<_i9.DebtModel>>(),
    transactionsBox: gh<_i4.Box<_i10.TransactionsModel>>(),
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
      _i22.GetCountryUseCase(repository: gh<_i11.CurrenciesRepository>()));
  gh.singleton<_i23.GetDebtUseCase>(
      _i23.GetDebtUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i24.GetTransactionsUseCase>(
      _i24.GetTransactionsUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.factory<_i25.HomeBloc>(
      () => _i25.HomeBloc(gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i26.LocalCategoryDataManager>(
      _i27.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i8.CategoryModel>>()));
  gh.factory<_i28.LocalExpenseDataManager>(
      () => _i29.LocalExpenseDataManagerImpl(gh<_i30.Box<_i6.ExpenseModel>>()));
  gh.factory<_i31.LocalRecurringDataManager>(() =>
      _i32.LocalRecurringDataManagerImpl(gh<_i4.Box<_i5.RecurringModel>>()));
  gh.singleton<_i33.RecurringRepository>(_i34.RecurringRepositoryImpl(
    gh<_i31.LocalRecurringDataManager>(),
    gh<_i28.LocalExpenseDataManager>(),
  ));
  gh.singleton<_i35.Settings>(
      _i35.Settings(gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i36.SettingsController>(
      _i36.SettingsController(gh<_i35.Settings>()));
  gh.singleton<_i37.UpdateDebtUseCase>(
      _i37.UpdateDebtUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i38.AccountLocalDataSource>(_i38.AccountLocalDataSourceImpl(
      accountBox: gh<_i4.Box<_i7.AccountModel>>()));
  gh.singleton<_i39.AccountRepository>(_i40.AccountRepositoryImpl(
      dataSource: gh<_i38.AccountLocalDataSource>()));
  gh.singleton<_i41.AddAccountUseCase>(
      _i41.AddAccountUseCase(accountRepository: gh<_i39.AccountRepository>()));
  gh.singleton<_i42.AddDebtUseCase>(
      _i42.AddDebtUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i43.AddRecurringUseCase>(
      _i43.AddRecurringUseCase(gh<_i33.RecurringRepository>()));
  gh.singleton<_i44.AddTransactionUseCase>(
      _i44.AddTransactionUseCase(debtRepository: gh<_i16.DebtRepository>()));
  gh.singleton<_i45.CategoryRepository>(_i46.CategoryRepositoryImpl(
    dataSources: gh<_i26.LocalCategoryDataManager>(),
    settings: gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.factory<_i47.CountryCubit>(() => _i47.CountryCubit(
        gh<_i22.GetCountryUseCase>(),
        gh<_i36.SettingsController>(),
      ));
  gh.factory<_i48.DebtsBloc>(() => _i48.DebtsBloc(
        addDebtUseCase: gh<_i49.AddDebtUseCase>(),
        getDebtUseCase: gh<_i49.GetDebtUseCase>(),
        getTransactionsUseCase: gh<_i49.GetTransactionsUseCase>(),
        addTransactionUseCase: gh<_i49.AddTransactionUseCase>(),
        updateDebtUseCase: gh<_i49.UpdateDebtUseCase>(),
        deleteDebtUseCase: gh<_i49.DeleteDebtUseCase>(),
        deleteTransactionsUseCase: gh<_i49.DeleteTransactionsUseCase>(),
        deleteTransactionUseCase: gh<_i49.DeleteTransactionUseCase>(),
      ));
  gh.singleton<_i50.DeleteAccountUseCase>(_i50.DeleteAccountUseCase(
      accountRepository: gh<_i39.AccountRepository>()));
  gh.singleton<_i51.DeleteCategoryUseCase>(_i51.DeleteCategoryUseCase(
      categoryRepository: gh<_i45.CategoryRepository>()));
  gh.singleton<_i52.ExpenseRepository>(_i53.ExpenseRepositoryImpl(
      dataSource: gh<_i28.LocalExpenseDataManager>()));
  gh.singleton<_i54.FilterExpenseUseCase>(
      _i54.FilterExpenseUseCase(gh<_i52.ExpenseRepository>()));
  gh.singleton<_i55.GetAccountUseCase>(
      _i55.GetAccountUseCase(accountRepository: gh<_i39.AccountRepository>()));
  gh.singleton<_i56.GetAccountsUseCase>(
      _i56.GetAccountsUseCase(accountRepository: gh<_i39.AccountRepository>()));
  gh.singleton<_i57.GetCategoryUseCase>(_i57.GetCategoryUseCase(
      categoryRepository: gh<_i45.CategoryRepository>()));
  gh.singleton<_i58.GetExpenseUseCase>(
      _i58.GetExpenseUseCase(expenseRepository: gh<_i52.ExpenseRepository>()));
  gh.singleton<_i59.GetExpensesFromAccountIdUseCase>(
      _i59.GetExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i52.ExpenseRepository>()));
  gh.singleton<_i60.GetExpensesFromCategoryIdUseCase>(
      _i60.GetExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i52.ExpenseRepository>()));
  gh.singleton<_i61.GetExpensesUseCase>(
      _i61.GetExpensesUseCase(expenseRepository: gh<_i52.ExpenseRepository>()));
  gh.factory<_i62.RecurringCubit>(
      () => _i62.RecurringCubit(gh<_i63.AddRecurringUseCase>()));
  gh.factory<_i64.SearchCubit>(
      () => _i64.SearchCubit(gh<_i65.FilterExpenseUseCase>()));
  gh.singleton<_i66.SummaryController>(_i66.SummaryController(
    getAccountUseCase: gh<_i67.GetAccountUseCase>(),
    getCategoryUseCase: gh<_i68.GetCategoryUseCase>(),
    getExpensesFromCategoryIdUseCase:
        gh<_i65.GetExpensesFromCategoryIdUseCase>(),
  ));
  gh.singleton<_i69.UpdateAccountUseCase>(_i69.UpdateAccountUseCase(
      accountRepository: gh<_i39.AccountRepository>()));
  gh.singleton<_i70.UpdateCategoryUseCase>(_i70.UpdateCategoryUseCase(
      categoryRepository: gh<_i45.CategoryRepository>()));
  gh.singleton<_i71.UpdateExpensesUseCase>(_i71.UpdateExpensesUseCase(
      expenseRepository: gh<_i52.ExpenseRepository>()));
  gh.singleton<_i72.AddCategoryUseCase>(_i72.AddCategoryUseCase(
      categoryRepository: gh<_i45.CategoryRepository>()));
  gh.singleton<_i73.AddExpenseUseCase>(
      _i73.AddExpenseUseCase(expenseRepository: gh<_i52.ExpenseRepository>()));
  gh.factory<_i74.BudgetCubit>(() => _i74.BudgetCubit(
        gh<_i65.GetExpensesUseCase>(),
        gh<_i68.GetCategoryUseCase>(),
      ));
  gh.singleton<_i75.DeleteExpenseUseCase>(_i75.DeleteExpenseUseCase(
      expenseRepository: gh<_i52.ExpenseRepository>()));
  gh.singleton<_i76.DeleteExpensesFromAccountIdUseCase>(
      _i76.DeleteExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i52.ExpenseRepository>()));
  gh.singleton<_i77.DeleteExpensesFromCategoryIdUseCase>(
      _i77.DeleteExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i52.ExpenseRepository>()));
  gh.factory<_i78.ExpenseBloc>(() => _i78.ExpenseBloc(
        gh<_i36.SettingsController>(),
        expenseUseCase: gh<_i65.GetExpenseUseCase>(),
        accountUseCase: gh<_i67.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i65.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i65.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i71.UpdateExpensesUseCase>(),
        accountsUseCase: gh<_i67.GetAccountsUseCase>(),
      ));
  gh.factory<_i79.AccountsBloc>(() => _i79.AccountsBloc(
        getAccountUseCase: gh<_i67.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i67.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i65.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i67.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i67.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i68.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i65.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i67.UpdateAccountUseCase>(),
      ));
  gh.factory<_i80.CategoryBloc>(() => _i80.CategoryBloc(
        getCategoryUseCase: gh<_i68.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i68.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i68.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i65.DeleteExpensesFromCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i68.UpdateCategoryUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i81.HiveBoxModule {}
