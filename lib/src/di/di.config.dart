// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i27;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/data/accounts/data_sources/account_local_data_source.dart'
    as _i21;
import 'package:paisa/src/data/accounts/data_sources/account_local_data_source_impl.dart'
    as _i22;
import 'package:paisa/src/data/accounts/model/account.dart' as _i6;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i29;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i23;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i24;
import 'package:paisa/src/data/category/model/category.dart' as _i7;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i32;
import 'package:paisa/src/data/currencies/repository/currencies_repository_impl.dart'
    as _i11;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source.dart'
    as _i12;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source_impl.dart'
    as _i13;
import 'package:paisa/src/data/debt/models/debt.dart' as _i8;
import 'package:paisa/src/data/debt/models/transaction.dart' as _i9;
import 'package:paisa/src/data/debt/repository/debt_repository_impl.dart'
    as _i15;
import 'package:paisa/src/data/expense/data_sources/expense_manager_local_data_source.dart'
    as _i25;
import 'package:paisa/src/data/expense/data_sources/expense_manager_local_data_source_impl.dart'
    as _i26;
import 'package:paisa/src/data/expense/model/expense.dart' as _i5;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i37;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i18;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i28;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i45;
import 'package:paisa/src/domain/account/use_case/add_account_use_case.dart'
    as _i30;
import 'package:paisa/src/domain/account/use_case/delete_account_use_case.dart'
    as _i34;
import 'package:paisa/src/domain/account/use_case/get_account_use_case.dart'
    as _i38;
import 'package:paisa/src/domain/account/use_case/get_accounts_use_case.dart'
    as _i39;
import 'package:paisa/src/domain/account/use_case/get_expense_from_account_use_case.dart'
    as _i42;
import 'package:paisa/src/domain/category/repository/category_repository.dart'
    as _i31;
import 'package:paisa/src/domain/category/use_case/add_category_use_case.dart'
    as _i47;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i46;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i35;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i40;
import 'package:paisa/src/domain/currencies/repository/currencies_repository.dart'
    as _i10;
import 'package:paisa/src/domain/currencies/use_case/get_currencies_use_case.dart'
    as _i19;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i14;
import 'package:paisa/src/domain/debt/use_case/debt_use_case.dart' as _i16;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i36;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i48;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i50;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i52;
import 'package:paisa/src/domain/expense/use_case/get_expense_use_case.dart'
    as _i41;
import 'package:paisa/src/domain/expense/use_case/get_expenses_use_case.dart'
    as _i43;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i44;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i49;
import 'package:paisa/src/presentation/currency_selector/bloc/currency_selector_bloc.dart'
    as _i33;
import 'package:paisa/src/presentation/debits/cubit/debts_cubit.dart' as _i17;
import 'package:paisa/src/presentation/expense/bloc/expense_bloc.dart' as _i51;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i20;

import 'module/hive_module.dart' as _i53;

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
  gh.singleton<_i4.Box<_i5.Expense>>(hiveModule.expenseBox);
  gh.singleton<_i4.Box<_i6.Account>>(hiveModule.accountBox);
  gh.singleton<_i4.Box<_i7.Category>>(hiveModule.categoryBox);
  gh.singleton<_i4.Box<_i8.Debt>>(hiveModule.debtsBox);
  gh.singleton<_i4.Box<_i9.Transaction>>(hiveModule.transactionsBox);
  gh.singleton<_i4.Box<dynamic>>(
    hiveModule.boxDynamic,
    instanceName: 'settings',
  );
  gh.singleton<_i10.CurrenciesRepository>(
      _i11.CurrencySelectorRepositoryImpl());
  gh.singleton<_i12.DebtLocalDataSource>(_i13.DebtLocalDataSourceImpl(
    debtBox: gh<_i4.Box<_i8.Debt>>(),
    transactionsBox: gh<_i4.Box<_i9.Transaction>>(),
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
  gh.factory<_i20.HomeBloc>(() => _i20.HomeBloc());
  gh.singleton<_i21.LocalAccountManagerDataSource>(
      _i22.LocalAccountManagerDataSourceImpl(
    accountBox: gh<_i4.Box<_i6.Account>>(),
    expenseBox: gh<_i4.Box<_i5.Expense>>(),
  ));
  gh.singleton<_i23.LocalCategoryManagerDataSource>(
      _i24.LocalCategoryManagerDataSourceImpl(gh<_i4.Box<_i7.Category>>()));
  gh.factory<_i25.LocalExpenseManagerDataSource>(() =>
      _i26.LocalExpenseManagerDataSourceImpl(gh<_i27.Box<_i5.Expense>>()));
  gh.singleton<_i28.AccountRepository>(_i29.AccountRepositoryImpl(
      dataSource: gh<_i21.LocalAccountManagerDataSource>()));
  gh.singleton<_i30.AddAccountUseCase>(
      _i30.AddAccountUseCase(accountRepository: gh<_i28.AccountRepository>()));
  gh.singleton<_i31.CategoryRepository>(_i32.CategoryRepositoryImpl(
      dataSources: gh<_i23.LocalCategoryManagerDataSource>()));
  gh.factory<_i33.CurrencySelectorBloc>(() => _i33.CurrencySelectorBloc(
        accounts: gh<_i4.Box<_i6.Account>>(),
        categories: gh<_i4.Box<_i7.Category>>(),
        currenciesUseCase: gh<_i19.GetCurrenciesUseCase>(),
      ));
  gh.singleton<_i34.DeleteAccountUseCase>(_i34.DeleteAccountUseCase(
      accountRepository: gh<_i28.AccountRepository>()));
  gh.singleton<_i35.DeleteCategoryUseCase>(_i35.DeleteCategoryUseCase(
      categoryRepository: gh<_i31.CategoryRepository>()));
  gh.singleton<_i36.ExpenseRepository>(_i37.ExpenseRepositoryImpl(
      dataSource: gh<_i25.LocalExpenseManagerDataSource>()));
  gh.singleton<_i38.GetAccountUseCase>(
      _i38.GetAccountUseCase(accountRepository: gh<_i28.AccountRepository>()));
  gh.singleton<_i39.GetAccountsUseCase>(
      _i39.GetAccountsUseCase(accountRepository: gh<_i28.AccountRepository>()));
  gh.singleton<_i40.GetCategoryUseCase>(_i40.GetCategoryUseCase(
      categoryRepository: gh<_i31.CategoryRepository>()));
  gh.singleton<_i41.GetExpenseUseCase>(
      _i41.GetExpenseUseCase(expenseRepository: gh<_i36.ExpenseRepository>()));
  gh.singleton<_i42.GetExpensesFromAccountUseCase>(
      _i42.GetExpensesFromAccountUseCase(
          accountRepository: gh<_i28.AccountRepository>()));
  gh.singleton<_i43.GetExpensesUseCase>(
      _i43.GetExpensesUseCase(expenseRepository: gh<_i36.ExpenseRepository>()));
  gh.factory<_i44.AccountsBloc>(() => _i44.AccountsBloc(
        getAccountUseCase: gh<_i45.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i45.DeleteAccountUseCase>(),
        getExpensesFromAccountUseCase: gh<_i45.GetExpensesFromAccountUseCase>(),
        addAccountUseCase: gh<_i45.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i45.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i46.GetCategoryUseCase>(),
      ));
  gh.singleton<_i47.AddCategoryUseCase>(_i47.AddCategoryUseCase(
      categoryRepository: gh<_i31.CategoryRepository>()));
  gh.singleton<_i48.AddExpenseUseCase>(
      _i48.AddExpenseUseCase(expenseRepository: gh<_i36.ExpenseRepository>()));
  gh.factory<_i49.CategoryBloc>(() => _i49.CategoryBloc(
        getCategoryUseCase: gh<_i46.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i46.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i46.DeleteCategoryUseCase>(),
      ));
  gh.singleton<_i50.DeleteExpenseUseCase>(_i50.DeleteExpenseUseCase(
      expenseRepository: gh<_i36.ExpenseRepository>()));
  gh.factory<_i51.ExpenseBloc>(() => _i51.ExpenseBloc(
        expenseUseCase: gh<_i52.GetExpenseUseCase>(),
        accountUseCase: gh<_i38.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i52.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i52.DeleteExpenseUseCase>(),
      ));
  return getIt;
}

class _$HiveModule extends _i53.HiveModule {}
