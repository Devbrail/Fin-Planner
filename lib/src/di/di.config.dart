// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i25;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/data/accounts/data_sources/account_local_data_source.dart'
    as _i19;
import 'package:paisa/src/data/accounts/data_sources/account_local_data_source_impl.dart'
    as _i20;
import 'package:paisa/src/data/accounts/model/account.dart' as _i6;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i27;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i21;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i22;
import 'package:paisa/src/data/category/model/category.dart' as _i7;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i30;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source.dart'
    as _i11;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source_impl.dart'
    as _i12;
import 'package:paisa/src/data/debt/models/debt.dart' as _i8;
import 'package:paisa/src/data/debt/models/transaction.dart' as _i9;
import 'package:paisa/src/data/debt/repository/debt_repository_impl.dart'
    as _i14;
import 'package:paisa/src/data/expense/data_sources/expense_manager_local_data_source.dart'
    as _i23;
import 'package:paisa/src/data/expense/data_sources/expense_manager_local_data_source_impl.dart'
    as _i24;
import 'package:paisa/src/data/expense/model/expense.dart' as _i5;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i34;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i17;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i26;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i41;
import 'package:paisa/src/domain/account/use_case/add_account_use_case.dart'
    as _i28;
import 'package:paisa/src/domain/account/use_case/delete_account_use_case.dart'
    as _i31;
import 'package:paisa/src/domain/account/use_case/get_account_use_case.dart'
    as _i35;
import 'package:paisa/src/domain/account/use_case/get_accounts_use_case.dart'
    as _i36;
import 'package:paisa/src/domain/category/repository/category_repository.dart'
    as _i29;
import 'package:paisa/src/domain/category/use_case/add_category_use_case.dart'
    as _i42;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i45;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i32;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i37;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i13;
import 'package:paisa/src/domain/debt/use_case/debt_use_case.dart' as _i15;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i33;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i43;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i46;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i48;
import 'package:paisa/src/domain/expense/use_case/get_expense_use_case.dart'
    as _i38;
import 'package:paisa/src/domain/expense/use_case/get_expenses_use_case.dart'
    as _i39;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i40;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i44;
import 'package:paisa/src/presentation/debits/cubit/debts_cubit.dart' as _i16;
import 'package:paisa/src/presentation/expense/bloc/expense_bloc.dart' as _i47;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i18;
import 'package:paisa/src/presentation/login/bloc/currency_selector_bloc.dart'
    as _i10;

import 'module/hive_module.dart' as _i49;

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
  gh.factory<_i10.CurrencySelectorBloc>(() => _i10.CurrencySelectorBloc(
        accounts: gh<_i4.Box<_i6.Account>>(),
        categories: gh<_i4.Box<_i7.Category>>(),
      ));
  gh.singleton<_i11.DebtLocalDataSource>(_i12.DebtLocalDataSourceImpl(
    debtBox: gh<_i4.Box<_i8.Debt>>(),
    transactionsBox: gh<_i4.Box<_i9.Transaction>>(),
  ));
  gh.singleton<_i13.DebtRepository>(
      _i14.DebtRepositoryImpl(dataSource: gh<_i11.DebtLocalDataSource>()));
  gh.singleton<_i15.DebtUseCase>(
      _i15.DebtUseCase(debtRepository: gh<_i13.DebtRepository>()));
  gh.factory<_i16.DebtsBloc>(
      () => _i16.DebtsBloc(useCase: gh<_i15.DebtUseCase>()));
  gh.singleton<_i17.FileHandler>(_i17.FileHandler());
  gh.factory<_i18.HomeBloc>(() => _i18.HomeBloc());
  gh.singleton<_i19.LocalAccountManagerDataSource>(
      _i20.LocalAccountManagerDataSourceImpl(
    accountBox: gh<_i4.Box<_i6.Account>>(),
    expenseBox: gh<_i4.Box<_i5.Expense>>(),
  ));
  gh.singleton<_i21.LocalCategoryManagerDataSource>(
      _i22.LocalCategoryManagerDataSourceImpl(gh<_i4.Box<_i7.Category>>()));
  gh.factory<_i23.LocalExpenseManagerDataSource>(() =>
      _i24.LocalExpenseManagerDataSourceImpl(gh<_i25.Box<_i5.Expense>>()));
  gh.singleton<_i26.AccountRepository>(_i27.AccountRepositoryImpl(
      dataSource: gh<_i19.LocalAccountManagerDataSource>()));
  gh.singleton<_i28.AddAccountUseCase>(
      _i28.AddAccountUseCase(accountRepository: gh<_i26.AccountRepository>()));
  gh.singleton<_i29.CategoryRepository>(_i30.CategoryRepositoryImpl(
      dataSources: gh<_i21.LocalCategoryManagerDataSource>()));
  gh.singleton<_i31.DeleteAccountUseCase>(_i31.DeleteAccountUseCase(
      accountRepository: gh<_i26.AccountRepository>()));
  gh.singleton<_i32.DeleteCategoryUseCase>(_i32.DeleteCategoryUseCase(
      categoryRepository: gh<_i29.CategoryRepository>()));
  gh.singleton<_i33.ExpenseRepository>(_i34.ExpenseRepositoryImpl(
      dataSource: gh<_i23.LocalExpenseManagerDataSource>()));
  gh.singleton<_i35.GetAccountUseCase>(
      _i35.GetAccountUseCase(accountRepository: gh<_i26.AccountRepository>()));
  gh.singleton<_i36.GetAccountsUseCase>(
      _i36.GetAccountsUseCase(accountRepository: gh<_i26.AccountRepository>()));
  gh.singleton<_i37.GetCategoryUseCase>(_i37.GetCategoryUseCase(
      categoryRepository: gh<_i29.CategoryRepository>()));
  gh.singleton<_i38.GetExpenseUseCase>(
      _i38.GetExpenseUseCase(expenseRepository: gh<_i33.ExpenseRepository>()));
  gh.singleton<_i39.GetExpensesUseCase>(
      _i39.GetExpensesUseCase(expenseRepository: gh<_i33.ExpenseRepository>()));
  gh.factory<_i40.AccountsBloc>(() => _i40.AccountsBloc(
        getAccountUseCase: gh<_i41.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i41.DeleteAccountUseCase>(),
        addAccountUseCase: gh<_i41.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i41.GetAccountsUseCase>(),
      ));
  gh.singleton<_i42.AddCategoryUseCase>(_i42.AddCategoryUseCase(
      categoryRepository: gh<_i29.CategoryRepository>()));
  gh.singleton<_i43.AddExpenseUseCase>(
      _i43.AddExpenseUseCase(expenseRepository: gh<_i33.ExpenseRepository>()));
  gh.factory<_i44.CategoryBloc>(() => _i44.CategoryBloc(
        getCategoryUseCase: gh<_i45.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i45.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i45.DeleteCategoryUseCase>(),
      ));
  gh.singleton<_i46.DeleteExpenseUseCase>(_i46.DeleteExpenseUseCase(
      expenseRepository: gh<_i33.ExpenseRepository>()));
  gh.factory<_i47.ExpenseBloc>(() => _i47.ExpenseBloc(
        expenseUseCase: gh<_i48.GetExpenseUseCase>(),
        accountUseCase: gh<_i35.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i48.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i48.DeleteExpenseUseCase>(),
      ));
  return getIt;
}

class _$HiveModule extends _i49.HiveModule {}
