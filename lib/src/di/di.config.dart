// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i28;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager.dart'
    as _i22;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager_impl.dart'
    as _i23;
import 'package:paisa/src/data/accounts/model/account_model.dart' as _i8;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i30;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i24;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i25;
import 'package:paisa/src/data/category/model/category_model.dart' as _i9;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i33;
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
    as _i26;
import 'package:paisa/src/data/expense/data_sources/local_expense_data_manager_impl.dart'
    as _i27;
import 'package:paisa/src/data/expense/model/expense_model.dart' as _i7;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i38;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i18;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i29;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i56;
import 'package:paisa/src/domain/account/use_case/add_account_use_case.dart'
    as _i31;
import 'package:paisa/src/domain/account/use_case/delete_account_use_case.dart'
    as _i35;
import 'package:paisa/src/domain/account/use_case/get_account_use_case.dart'
    as _i39;
import 'package:paisa/src/domain/account/use_case/get_accounts_use_case.dart'
    as _i40;
import 'package:paisa/src/domain/account/use_case/update_account_use_case.dart'
    as _i46;
import 'package:paisa/src/domain/category/repository/category_repository.dart'
    as _i32;
import 'package:paisa/src/domain/category/use_case/add_category_use_case.dart'
    as _i48;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i57;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i36;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i41;
import 'package:paisa/src/domain/currencies/repository/currencies_repository.dart'
    as _i10;
import 'package:paisa/src/domain/currencies/use_case/get_country_user_case.dart'
    as _i19;
import 'package:paisa/src/domain/currencies/use_case/get_currencies_use_case.dart'
    as _i20;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i14;
import 'package:paisa/src/domain/debt/use_case/debt_use_case.dart' as _i16;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i37;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i49;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i50;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_account_id.dart'
    as _i51;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_category_id.dart'
    as _i52;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i54;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_account_id.dart'
    as _i43;
import 'package:paisa/src/domain/expense/use_case/get_expense_from_category_id.dart'
    as _i44;
import 'package:paisa/src/domain/expense/use_case/get_expense_use_case.dart'
    as _i42;
import 'package:paisa/src/domain/expense/use_case/get_expenses_use_case.dart'
    as _i45;
import 'package:paisa/src/domain/expense/use_case/update_expense_use_case.dart'
    as _i47;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i55;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i58;
import 'package:paisa/src/presentation/currency_selector/bloc/currency_selector_bloc.dart'
    as _i34;
import 'package:paisa/src/presentation/debits/cubit/debts_cubit.dart' as _i17;
import 'package:paisa/src/presentation/expense/bloc/expense_bloc.dart' as _i53;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i21;

import 'module/hive_module.dart' as _i59;

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
  gh.singleton<_i4.Box<_i7.ExpenseModel>>(hiveModule.expenseBox);
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
  gh.singleton<_i16.DebtUseCase>(
      _i16.DebtUseCase(debtRepository: gh<_i14.DebtRepository>()));
  gh.factory<_i17.DebtsBloc>(
      () => _i17.DebtsBloc(useCase: gh<_i16.DebtUseCase>()));
  gh.singleton<_i18.FileHandler>(_i18.FileHandler());
  gh.factory<_i19.GetCurrenciesUseCase>(() =>
      _i19.GetCurrenciesUseCase(repository: gh<_i10.CurrenciesRepository>()));
  gh.factory<_i20.GetCurrenciesUseCase>(() =>
      _i20.GetCurrenciesUseCase(repository: gh<_i10.CurrenciesRepository>()));
  gh.factory<_i21.HomeBloc>(() => _i21.HomeBloc());
  gh.singleton<_i22.LocalAccountDataManager>(_i23.LocalAccountDataManagerImpl(
      accountBox: gh<_i4.Box<_i8.AccountModel>>()));
  gh.singleton<_i24.LocalCategoryManagerDataSource>(
      _i25.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i9.CategoryModel>>()));
  gh.factory<_i26.LocalExpenseDataManager>(
      () => _i27.LocalExpenseDataManagerImpl(gh<_i28.Box<_i7.ExpenseModel>>()));
  gh.singleton<_i29.AccountRepository>(_i30.AccountRepositoryImpl(
      dataSource: gh<_i22.LocalAccountDataManager>()));
  gh.singleton<_i31.AddAccountUseCase>(
      _i31.AddAccountUseCase(accountRepository: gh<_i29.AccountRepository>()));
  gh.singleton<_i32.CategoryRepository>(_i33.CategoryRepositoryImpl(
      dataSources: gh<_i24.LocalCategoryManagerDataSource>()));
  gh.factory<_i34.CurrencySelectorBloc>(() => _i34.CurrencySelectorBloc(
        accounts: gh<_i4.Box<_i8.AccountModel>>(),
        categories: gh<_i4.Box<_i9.CategoryModel>>(),
        currenciesUseCase: gh<_i20.GetCurrenciesUseCase>(),
      ));
  gh.singleton<_i35.DeleteAccountUseCase>(_i35.DeleteAccountUseCase(
      accountRepository: gh<_i29.AccountRepository>()));
  gh.singleton<_i36.DeleteCategoryUseCase>(_i36.DeleteCategoryUseCase(
      categoryRepository: gh<_i32.CategoryRepository>()));
  gh.singleton<_i37.ExpenseRepository>(_i38.ExpenseRepositoryImpl(
      dataSource: gh<_i26.LocalExpenseDataManager>()));
  gh.singleton<_i39.GetAccountUseCase>(
      _i39.GetAccountUseCase(accountRepository: gh<_i29.AccountRepository>()));
  gh.singleton<_i40.GetAccountsUseCase>(
      _i40.GetAccountsUseCase(accountRepository: gh<_i29.AccountRepository>()));
  gh.singleton<_i41.GetCategoryUseCase>(_i41.GetCategoryUseCase(
      categoryRepository: gh<_i32.CategoryRepository>()));
  gh.singleton<_i42.GetExpenseUseCase>(
      _i42.GetExpenseUseCase(expenseRepository: gh<_i37.ExpenseRepository>()));
  gh.singleton<_i43.GetExpensesFromAccountIdUseCase>(
      _i43.GetExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i37.ExpenseRepository>()));
  gh.singleton<_i44.GetExpensesFromCategoryIdUseCase>(
      _i44.GetExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i37.ExpenseRepository>()));
  gh.singleton<_i45.GetExpensesUseCase>(
      _i45.GetExpensesUseCase(expenseRepository: gh<_i37.ExpenseRepository>()));
  gh.singleton<_i46.UpdateAccountUseCase>(_i46.UpdateAccountUseCase(
      accountRepository: gh<_i29.AccountRepository>()));
  gh.singleton<_i47.UpdateExpensesUseCase>(_i47.UpdateExpensesUseCase(
      expenseRepository: gh<_i37.ExpenseRepository>()));
  gh.singleton<_i48.AddCategoryUseCase>(_i48.AddCategoryUseCase(
      categoryRepository: gh<_i32.CategoryRepository>()));
  gh.singleton<_i49.AddExpenseUseCase>(
      _i49.AddExpenseUseCase(expenseRepository: gh<_i37.ExpenseRepository>()));
  gh.singleton<_i50.DeleteExpenseUseCase>(_i50.DeleteExpenseUseCase(
      expenseRepository: gh<_i37.ExpenseRepository>()));
  gh.singleton<_i51.DeleteExpensesFromAccountIdUseCase>(
      _i51.DeleteExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i37.ExpenseRepository>()));
  gh.singleton<_i52.DeleteExpensesFromCategoryIdUseCase>(
      _i52.DeleteExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i37.ExpenseRepository>()));
  gh.factory<_i53.ExpenseBloc>(() => _i53.ExpenseBloc(
        expenseUseCase: gh<_i54.GetExpenseUseCase>(),
        accountUseCase: gh<_i39.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i54.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i54.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i47.UpdateExpensesUseCase>(),
      ));
  gh.factory<_i55.AccountsBloc>(() => _i55.AccountsBloc(
        getAccountUseCase: gh<_i56.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i56.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i54.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i56.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i56.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i57.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i54.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i56.UpdateAccountUseCase>(),
      ));
  gh.factory<_i58.CategoryBloc>(() => _i58.CategoryBloc(
        getCategoryUseCase: gh<_i57.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i57.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i57.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i54.DeleteExpensesFromCategoryIdUseCase>(),
      ));
  return getIt;
}

class _$HiveModule extends _i59.HiveModule {}
