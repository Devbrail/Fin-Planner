// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i31;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager.dart'
    as _i25;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager_impl.dart'
    as _i26;
import 'package:paisa/src/data/accounts/model/account_model.dart' as _i8;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i36;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i27;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i28;
import 'package:paisa/src/data/category/model/category_model.dart' as _i9;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i41;
import 'package:paisa/src/data/currencies/repository/currencies_repository_impl.dart'
    as _i11;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source.dart'
    as _i12;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source_impl.dart'
    as _i13;
import 'package:paisa/src/data/debt/models/debt_model.dart' as _i6;
import 'package:paisa/src/data/debt/models/transactions_model.dart' as _i5;
import 'package:paisa/src/data/debt/repository/debt_repository_impl.dart'
    as _i15;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager.dart'
    as _i29;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager_impl.dart'
    as _i30;
import 'package:paisa/src/data/expense/model/expense_model.dart' as _i7;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i48;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i19;
import 'package:paisa/src/data/settings/settings.dart' as _i32;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i35;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i57;
import 'package:paisa/src/domain/account/use_case/add_account_use_case.dart'
    as _i37;
import 'package:paisa/src/domain/account/use_case/delete_account_use_case.dart'
    as _i45;
import 'package:paisa/src/domain/account/use_case/get_account_use_case.dart'
    as _i49;
import 'package:paisa/src/domain/account/use_case/get_accounts_use_case.dart'
    as _i50;
import 'package:paisa/src/domain/account/use_case/update_account_use_case.dart'
    as _i59;
import 'package:paisa/src/domain/category/repository/category_repository.dart'
    as _i40;
import 'package:paisa/src/domain/category/use_case/add_category_use_case.dart'
    as _i62;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i58;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i46;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i51;
import 'package:paisa/src/domain/category/use_case/update_category_use_case.dart'
    as _i60;
import 'package:paisa/src/domain/currencies/repository/currencies_repository.dart'
    as _i10;
import 'package:paisa/src/domain/currencies/use_case/get_country_user_case.dart'
    as _i21;
import 'package:paisa/src/domain/currencies/use_case/get_currencies_use_case.dart'
    as _i20;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i14;
import 'package:paisa/src/domain/debt/use_case/add_debt_use.case.dart' as _i38;
import 'package:paisa/src/domain/debt/use_case/add_transaction_use_case.dart'
    as _i39;
import 'package:paisa/src/domain/debt/use_case/debt_use_case.dart' as _i44;
import 'package:paisa/src/domain/debt/use_case/delete_debt_use_case.dart'
    as _i16;
import 'package:paisa/src/domain/debt/use_case/delete_transaction_use_case.dart'
    as _i17;
import 'package:paisa/src/domain/debt/use_case/delete_transactions_use_case.dart'
    as _i18;
import 'package:paisa/src/domain/debt/use_case/get_debt_use_case.dart' as _i22;
import 'package:paisa/src/domain/debt/use_case/get_transactions_use_case.dart'
    as _i23;
import 'package:paisa/src/domain/debt/use_case/update_debt_use.case.dart'
    as _i34;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i47;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i63;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i66;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_account_id.dart'
    as _i67;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_category_id.dart'
    as _i68;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i65;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_account_id.dart'
    as _i53;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_category_id.dart'
    as _i54;
import 'package:paisa/src/domain/expense/use_case/get_expense_use_case.dart'
    as _i52;
import 'package:paisa/src/domain/expense/use_case/get_expenses_use_case.dart'
    as _i55;
import 'package:paisa/src/domain/expense/use_case/update_expense_use_case.dart'
    as _i61;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i70;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i71;
import 'package:paisa/src/presentation/currency_selector/bloc/currency_selector_bloc.dart'
    as _i42;
import 'package:paisa/src/presentation/debits/cubit/debts_cubit.dart' as _i43;
import 'package:paisa/src/presentation/expense/bloc/expense_bloc.dart' as _i69;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i24;
import 'package:paisa/src/presentation/overview/cubit/budget_cubit.dart'
    as _i64;
import 'package:paisa/src/presentation/summary/controller/settings_controller.dart'
    as _i33;
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart'
    as _i56;

import 'module/hive_module.dart' as _i72;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final hiveModule = _$HiveModule();
  gh.singleton<_i3.Authenticate>(_i3.Authenticate());
  gh.singleton<_i4.Box<dynamic>>(
    hiveModule.boxDynamic,
    instanceName: 'settings',
  );
  gh.singleton<_i4.Box<_i5.TransactionsModel>>(hiveModule.transactionsBox);
  gh.singleton<_i4.Box<_i6.DebtModel>>(hiveModule.debtsBox);
  gh.factory<_i4.Box<_i7.ExpenseModel>>(() => hiveModule.expenseBox);
  gh.singleton<_i4.Box<_i8.AccountModel>>(hiveModule.accountBox);
  gh.singleton<_i4.Box<_i9.CategoryModel>>(hiveModule.categoryBox);
  gh.singleton<_i10.CurrenciesRepository>(
      _i11.CurrencySelectorRepositoryImpl());
  gh.singleton<_i12.DebtLocalDataSource>(_i13.DebtLocalDataSourceImpl(
    debtBox: gh<_i4.Box<_i6.DebtModel>>(),
    transactionsBox: gh<_i4.Box<_i5.TransactionsModel>>(),
  ));
  gh.singleton<_i14.DebtRepository>(
      _i15.DebtRepositoryImpl(dataSource: gh<_i12.DebtLocalDataSource>()));
  gh.singleton<_i16.DeleteDebtUseCase>(
      _i16.DeleteDebtUseCase(debtRepository: gh<_i14.DebtRepository>()));
  gh.singleton<_i17.DeleteTransactionUseCase>(
      _i17.DeleteTransactionUseCase(debtRepository: gh<_i14.DebtRepository>()));
  gh.singleton<_i18.DeleteTransactionsUseCase>(_i18.DeleteTransactionsUseCase(
      debtRepository: gh<_i14.DebtRepository>()));
  gh.singleton<_i19.FileHandler>(_i19.FileHandler());
  gh.factory<_i20.GetCurrenciesUseCase>(() =>
      _i20.GetCurrenciesUseCase(repository: gh<_i10.CurrenciesRepository>()));
  gh.factory<_i21.GetCurrenciesUseCase>(() =>
      _i21.GetCurrenciesUseCase(repository: gh<_i10.CurrenciesRepository>()));
  gh.singleton<_i22.GetDebtUseCase>(
      _i22.GetDebtUseCase(debtRepository: gh<_i14.DebtRepository>()));
  gh.singleton<_i23.GetTransactionsUseCase>(
      _i23.GetTransactionsUseCase(debtRepository: gh<_i14.DebtRepository>()));
  gh.factory<_i24.HomeBloc>(() => _i24.HomeBloc());
  gh.singleton<_i25.LocalAccountDataManager>(_i26.LocalAccountDataManagerImpl(
      accountBox: gh<_i4.Box<_i8.AccountModel>>()));
  gh.singleton<_i27.LocalCategoryManagerDataSource>(
      _i28.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i9.CategoryModel>>()));
  gh.factory<_i29.LocalExpenseDataManager>(
      () => _i30.LocalExpenseDataManagerImpl(gh<_i31.Box<_i7.ExpenseModel>>()));
  gh.singleton<_i32.Settings>(
      _i32.Settings(gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i33.SettingsController>(
      _i33.SettingsController(gh<_i32.Settings>()));
  gh.singleton<_i34.UpdateDebtUseCase>(
      _i34.UpdateDebtUseCase(debtRepository: gh<_i14.DebtRepository>()));
  gh.singleton<_i35.AccountRepository>(_i36.AccountRepositoryImpl(
      dataSource: gh<_i25.LocalAccountDataManager>()));
  gh.singleton<_i37.AddAccountUseCase>(
      _i37.AddAccountUseCase(accountRepository: gh<_i35.AccountRepository>()));
  gh.singleton<_i38.AddDebtUseCase>(
      _i38.AddDebtUseCase(debtRepository: gh<_i14.DebtRepository>()));
  gh.singleton<_i39.AddTransactionUseCase>(
      _i39.AddTransactionUseCase(debtRepository: gh<_i14.DebtRepository>()));
  gh.singleton<_i40.CategoryRepository>(_i41.CategoryRepositoryImpl(
      dataSources: gh<_i27.LocalCategoryManagerDataSource>()));
  gh.factory<_i42.CurrencySelectorBloc>(() => _i42.CurrencySelectorBloc(
        accounts: gh<_i4.Box<_i8.AccountModel>>(),
        categories: gh<_i4.Box<_i9.CategoryModel>>(),
        currenciesUseCase: gh<_i20.GetCurrenciesUseCase>(),
      ));
  gh.factory<_i43.DebtsBloc>(() => _i43.DebtsBloc(
        addDebtUseCase: gh<_i44.AddDebtUseCase>(),
        getDebtUseCase: gh<_i44.GetDebtUseCase>(),
        getTransactionsUseCase: gh<_i44.GetTransactionsUseCase>(),
        addTransactionUseCase: gh<_i44.AddTransactionUseCase>(),
        updateDebtUseCase: gh<_i44.UpdateDebtUseCase>(),
        deleteDebtUseCase: gh<_i44.DeleteDebtUseCase>(),
        deleteTransactionsUseCase: gh<_i18.DeleteTransactionsUseCase>(),
        deleteTransactionUseCase: gh<_i44.DeleteTransactionUseCase>(),
      ));
  gh.singleton<_i45.DeleteAccountUseCase>(_i45.DeleteAccountUseCase(
      accountRepository: gh<_i35.AccountRepository>()));
  gh.singleton<_i46.DeleteCategoryUseCase>(_i46.DeleteCategoryUseCase(
      categoryRepository: gh<_i40.CategoryRepository>()));
  gh.singleton<_i47.ExpenseRepository>(_i48.ExpenseRepositoryImpl(
      dataSource: gh<_i29.LocalExpenseDataManager>()));
  gh.singleton<_i49.GetAccountUseCase>(
      _i49.GetAccountUseCase(accountRepository: gh<_i35.AccountRepository>()));
  gh.singleton<_i50.GetAccountsUseCase>(
      _i50.GetAccountsUseCase(accountRepository: gh<_i35.AccountRepository>()));
  gh.singleton<_i51.GetCategoryUseCase>(_i51.GetCategoryUseCase(
      categoryRepository: gh<_i40.CategoryRepository>()));
  gh.singleton<_i52.GetExpenseUseCase>(
      _i52.GetExpenseUseCase(expenseRepository: gh<_i47.ExpenseRepository>()));
  gh.singleton<_i53.GetExpensesFromAccountIdUseCase>(
      _i53.GetExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i47.ExpenseRepository>()));
  gh.singleton<_i54.GetExpensesFromCategoryIdUseCase>(
      _i54.GetExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i47.ExpenseRepository>()));
  gh.singleton<_i55.GetExpensesUseCase>(
      _i55.GetExpensesUseCase(expenseRepository: gh<_i47.ExpenseRepository>()));
  gh.singleton<_i56.SummaryController>(_i56.SummaryController(
    getAccountUseCase: gh<_i57.GetAccountUseCase>(),
    getCategoryUseCase: gh<_i58.GetCategoryUseCase>(),
  ));
  gh.singleton<_i59.UpdateAccountUseCase>(_i59.UpdateAccountUseCase(
      accountRepository: gh<_i35.AccountRepository>()));
  gh.singleton<_i60.UpdateCategoryUseCase>(_i60.UpdateCategoryUseCase(
      categoryRepository: gh<_i40.CategoryRepository>()));
  gh.singleton<_i61.UpdateExpensesUseCase>(_i61.UpdateExpensesUseCase(
      expenseRepository: gh<_i47.ExpenseRepository>()));
  gh.singleton<_i62.AddCategoryUseCase>(_i62.AddCategoryUseCase(
      categoryRepository: gh<_i40.CategoryRepository>()));
  gh.singleton<_i63.AddExpenseUseCase>(
      _i63.AddExpenseUseCase(expenseRepository: gh<_i47.ExpenseRepository>()));
  gh.factory<_i64.BudgetCubit>(() => _i64.BudgetCubit(
        gh<_i65.GetExpensesUseCase>(),
        gh<_i56.SummaryController>(),
      ));
  gh.singleton<_i66.DeleteExpenseUseCase>(_i66.DeleteExpenseUseCase(
      expenseRepository: gh<_i47.ExpenseRepository>()));
  gh.singleton<_i67.DeleteExpensesFromAccountIdUseCase>(
      _i67.DeleteExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i47.ExpenseRepository>()));
  gh.singleton<_i68.DeleteExpensesFromCategoryIdUseCase>(
      _i68.DeleteExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i47.ExpenseRepository>()));
  gh.factory<_i69.ExpenseBloc>(() => _i69.ExpenseBloc(
        expenseUseCase: gh<_i65.GetExpenseUseCase>(),
        accountUseCase: gh<_i49.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i65.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i65.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i61.UpdateExpensesUseCase>(),
      ));
  gh.factory<_i70.AccountsBloc>(() => _i70.AccountsBloc(
        getAccountUseCase: gh<_i57.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i57.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i65.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i57.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i57.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i58.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i65.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i57.UpdateAccountUseCase>(),
      ));
  gh.factory<_i71.CategoryBloc>(() => _i71.CategoryBloc(
        getCategoryUseCase: gh<_i58.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i58.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i58.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i65.DeleteExpensesFromCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i58.UpdateCategoryUseCase>(),
      ));
  return getIt;
}

class _$HiveModule extends _i72.HiveModule {}
