// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/data/accounts/data_sources/account_local_data_source.dart'
    as _i18;
import 'package:paisa/src/data/accounts/data_sources/account_local_data_source_impl.dart'
    as _i19;
import 'package:paisa/src/data/accounts/model/account.dart' as _i6;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i27;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i20;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i21;
import 'package:paisa/src/data/category/model/category.dart' as _i7;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i30;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source.dart'
    as _i8;
import 'package:paisa/src/data/debt/data_sources/debt_local_data_source_impl.dart'
    as _i9;
import 'package:paisa/src/data/debt/models/debt.dart' as _i10;
import 'package:paisa/src/data/debt/models/transaction.dart' as _i11;
import 'package:paisa/src/data/debt/repository/debt_repository_impl.dart'
    as _i13;
import 'package:paisa/src/data/expense/data_sources/expense_manager_local_data_source.dart'
    as _i22;
import 'package:paisa/src/data/expense/data_sources/expense_manager_local_data_source_impl.dart'
    as _i23;
import 'package:paisa/src/data/expense/model/expense.dart' as _i24;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i34;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i16;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i26;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i40;
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
    as _i41;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i44;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i32;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i37;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i12;
import 'package:paisa/src/domain/debt/use_case/debt_use_case.dart' as _i14;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i33;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i42;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i45;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i47;
import 'package:paisa/src/domain/expense/use_case/get_expense_use_case.dart'
    as _i38;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i39;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i43;
import 'package:paisa/src/presentation/debits/cubit/debts_cubit.dart' as _i15;
import 'package:paisa/src/presentation/expense/bloc/expense_bloc.dart' as _i46;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i17;
import 'package:paisa/src/presentation/login/bloc/currency_selector_bloc.dart'
    as _i4;
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart'
    as _i25;

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
  gh.singleton<_i3.Authenticate>(_i3.Authenticate());
  gh.factory<_i4.CurrencySelectorBloc>(() => _i4.CurrencySelectorBloc(
        accounts: gh<_i5.Box<_i6.Account>>(),
        categories: gh<_i5.Box<_i7.Category>>(),
        settings: gh<_i5.Box<dynamic>>(),
      ));
  gh.lazySingleton<_i8.DebtLocalDataSource>(() => _i9.DebtLocalDataSourceImpl(
        debtBox: gh<_i5.Box<_i10.Debt>>(),
        transactionsBox: gh<_i5.Box<_i11.Transaction>>(),
      ));
  gh.singleton<_i12.DebtRepository>(
      _i13.DebtRepositoryImpl(dataSource: gh<_i8.DebtLocalDataSource>()));
  gh.factory<_i14.DebtUseCase>(
      () => _i14.DebtUseCase(debtRepository: gh<_i12.DebtRepository>()));
  gh.factory<_i15.DebtsBloc>(
      () => _i15.DebtsBloc(useCase: gh<_i14.DebtUseCase>()));
  gh.singleton<_i16.FileHandler>(_i16.FileHandler());
  gh.factory<_i17.HomeBloc>(() => _i17.HomeBloc(gh<_i5.Box<dynamic>>()));
  gh.singleton<_i18.LocalAccountManagerDataSource>(
      _i19.LocalAccountManagerDataSourceImpl(gh<_i5.Box<_i6.Account>>()));
  gh.singleton<_i20.LocalCategoryManagerDataSource>(
      _i21.LocalCategoryManagerDataSourceImpl(gh<_i5.Box<_i7.Category>>()));
  gh.singleton<_i22.LocalExpenseManagerDataSource>(
      _i23.LocalExpenseManagerDataSourceImpl(gh<_i5.Box<_i24.Expense>>()));
  gh.singleton<_i25.SummaryController>(
      _i25.SummaryController(gh<_i5.Box<_i24.Expense>>()));
  gh.singleton<_i26.AccountRepository>(_i27.AccountRepositoryImpl(
      dataSource: gh<_i18.LocalAccountManagerDataSource>()));
  gh.factory<_i28.AddAccountUseCase>(() =>
      _i28.AddAccountUseCase(accountRepository: gh<_i26.AccountRepository>()));
  gh.singleton<_i29.CategoryRepository>(_i30.CategoryRepositoryImpl(
      dataSources: gh<_i20.LocalCategoryManagerDataSource>()));
  gh.factory<_i31.DeleteAccountUseCase>(() => _i31.DeleteAccountUseCase(
      accountRepository: gh<_i26.AccountRepository>()));
  gh.factory<_i32.DeleteCategoryUseCase>(() => _i32.DeleteCategoryUseCase(
      categoryRepository: gh<_i29.CategoryRepository>()));
  gh.singleton<_i33.ExpenseRepository>(_i34.ExpenseRepositoryImpl(
      dataSource: gh<_i22.LocalExpenseManagerDataSource>()));
  gh.factory<_i35.GetAccountUseCase>(() =>
      _i35.GetAccountUseCase(accountRepository: gh<_i26.AccountRepository>()));
  gh.factory<_i36.GetAccountsUseCase>(() =>
      _i36.GetAccountsUseCase(accountRepository: gh<_i26.AccountRepository>()));
  gh.factory<_i37.GetCategoryUseCase>(() => _i37.GetCategoryUseCase(
      categoryRepository: gh<_i29.CategoryRepository>()));
  gh.factory<_i38.GetExpenseUseCase>(() =>
      _i38.GetExpenseUseCase(expenseRepository: gh<_i33.ExpenseRepository>()));
  gh.factory<_i39.AccountsBloc>(() => _i39.AccountsBloc(
        getAccountUseCase: gh<_i40.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i40.DeleteAccountUseCase>(),
        addAccountUseCase: gh<_i40.AddAccountUseCase>(),
      ));
  gh.factory<_i41.AddCategoryUseCase>(() => _i41.AddCategoryUseCase(
      categoryRepository: gh<_i29.CategoryRepository>()));
  gh.factory<_i42.AddExpenseUseCase>(() =>
      _i42.AddExpenseUseCase(expenseRepository: gh<_i33.ExpenseRepository>()));
  gh.factory<_i43.CategoryBloc>(() => _i43.CategoryBloc(
        getCategoryUseCase: gh<_i44.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i44.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i44.DeleteCategoryUseCase>(),
      ));
  gh.factory<_i45.DeleteExpenseUseCase>(() => _i45.DeleteExpenseUseCase(
      expenseRepository: gh<_i33.ExpenseRepository>()));
  gh.factory<_i46.ExpenseBloc>(() => _i46.ExpenseBloc(
        expenseUseCase: gh<_i47.GetExpenseUseCase>(),
        accountUseCase: gh<_i35.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i47.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i47.DeleteExpenseUseCase>(),
      ));
  return getIt;
}
