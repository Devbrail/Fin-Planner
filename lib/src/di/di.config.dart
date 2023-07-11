// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i22;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i25;
import 'package:image_picker/image_picker.dart' as _i36;
import 'package:in_app_review/in_app_review.dart' as _i37;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/src/app/in_app.dart' as _i74;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager.dart'
    as _i48;
import 'package:paisa/src/data/accounts/data_sources/local_account_data_manager_impl.dart'
    as _i49;
import 'package:paisa/src/data/accounts/model/account_model.dart' as _i6;
import 'package:paisa/src/data/accounts/repository/account_repository_impl.dart'
    as _i51;
import 'package:paisa/src/data/category/data_sources/category_local_data_source.dart'
    as _i11;
import 'package:paisa/src/data/category/data_sources/category_local_data_source_impl.dart'
    as _i12;
import 'package:paisa/src/data/category/model/category_model.dart' as _i7;
import 'package:paisa/src/data/category/repository/category_repository_impl.dart'
    as _i58;
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
import 'package:paisa/src/data/expense/model/expense_model.dart' as _i8;
import 'package:paisa/src/data/expense/repository/expense_repository_impl.dart'
    as _i27;
import 'package:paisa/src/data/profile/repository/profile_repository_impl.dart'
    as _i41;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager.dart'
    as _i38;
import 'package:paisa/src/data/recurring/data_sources/local_recurring_data_manager_impl.dart'
    as _i39;
import 'package:paisa/src/data/recurring/model/recurring.dart' as _i9;
import 'package:paisa/src/data/recurring/repository/recurring_repository_impl.dart'
    as _i43;
import 'package:paisa/src/data/settings/authenticate.dart' as _i3;
import 'package:paisa/src/data/settings/file_handler.dart' as _i66;
import 'package:paisa/src/data/settings/repository/settings_repository_impl.dart'
    as _i80;
import 'package:paisa/src/domain/account/repository/account_repository.dart'
    as _i50;
import 'package:paisa/src/domain/account/use_case/account_use_case.dart'
    as _i84;
import 'package:paisa/src/domain/account/use_case/add_account_use_case.dart'
    as _i52;
import 'package:paisa/src/domain/account/use_case/delete_account_use_case.dart'
    as _i61;
import 'package:paisa/src/domain/account/use_case/get_account_use_case.dart'
    as _i67;
import 'package:paisa/src/domain/account/use_case/get_accounts_use_case.dart'
    as _i68;
import 'package:paisa/src/domain/account/use_case/update_account_use_case.dart'
    as _i86;
import 'package:paisa/src/domain/category/repository/category_repository.dart'
    as _i57;
import 'package:paisa/src/domain/category/use_case/add_category_use_case.dart'
    as _i89;
import 'package:paisa/src/domain/category/use_case/category_use_case.dart'
    as _i72;
import 'package:paisa/src/domain/category/use_case/delete_category_use_case.dart'
    as _i62;
import 'package:paisa/src/domain/category/use_case/get_category_use_case.dart'
    as _i69;
import 'package:paisa/src/domain/category/use_case/get_default_categories_use_case.dart'
    as _i70;
import 'package:paisa/src/domain/category/use_case/update_category_use_case.dart'
    as _i87;
import 'package:paisa/src/domain/currencies/repository/currencies_repository.dart'
    as _i13;
import 'package:paisa/src/domain/currencies/use_case/get_countries_user_case.dart'
    as _i29;
import 'package:paisa/src/domain/debt/repository/debit_repository.dart' as _i17;
import 'package:paisa/src/domain/debt/use_case/add_debt_use.case.dart' as _i53;
import 'package:paisa/src/domain/debt/use_case/add_transaction_use_case.dart'
    as _i56;
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
    as _i46;
import 'package:paisa/src/domain/expense/repository/expense_repository.dart'
    as _i26;
import 'package:paisa/src/domain/expense/use_case/add_expenses_use_case.dart'
    as _i54;
import 'package:paisa/src/domain/expense/use_case/delete_expense_use_case.dart'
    as _i63;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_account_id.dart'
    as _i64;
import 'package:paisa/src/domain/expense/use_case/delete_expenses_from_category_id.dart'
    as _i65;
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart'
    as _i45;
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
    as _i47;
import 'package:paisa/src/domain/profile/repository/profile_repository.dart'
    as _i40;
import 'package:paisa/src/domain/profile/use_case/image_picker_use_case.dart'
    as _i73;
import 'package:paisa/src/domain/profile/use_case/profile_use_case.dart'
    as _i76;
import 'package:paisa/src/domain/recurring/repository/recurring_repository.dart'
    as _i42;
import 'package:paisa/src/domain/recurring/use_case/add_recurring_use_case.dart'
    as _i55;
import 'package:paisa/src/domain/recurring/use_case/recurring_use_case.dart'
    as _i78;
import 'package:paisa/src/domain/settings/repository/settings_repository.dart'
    as _i79;
import 'package:paisa/src/domain/settings/use_case/file_export_use_case.dart'
    as _i93;
import 'package:paisa/src/domain/settings/use_case/file_import_use_case.dart'
    as _i94;
import 'package:paisa/src/domain/settings/use_case/setting_use_case.dart'
    as _i83;
import 'package:paisa/src/domain/settings/use_case/settings_use_case.dart'
    as _i81;
import 'package:paisa/src/presentation/accounts/bloc/accounts_bloc.dart'
    as _i88;
import 'package:paisa/src/presentation/category/bloc/category_bloc.dart'
    as _i91;
import 'package:paisa/src/presentation/currency_selector/cubit/country_cubit.dart'
    as _i92;
import 'package:paisa/src/presentation/debits/cubit/debts_bloc.dart' as _i59;
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart' as _i71;
import 'package:paisa/src/presentation/overview/cubit/budget_cubit.dart'
    as _i90;
import 'package:paisa/src/presentation/profile/cubit/profile_cubit.dart'
    as _i75;
import 'package:paisa/src/presentation/recurring/cubit/recurring_cubit.dart'
    as _i77;
import 'package:paisa/src/presentation/search/cubit/search_cubit.dart' as _i44;
import 'package:paisa/src/presentation/settings/cubit/settings_cubit.dart'
    as _i95;
import 'package:paisa/src/presentation/summary/controller/summary_controller.dart'
    as _i82;
import 'package:paisa/src/presentation/transaction/bloc/transaction_bloc.dart'
    as _i85;

import 'module/hive_module.dart' as _i97;
import 'module/service_module.dart' as _i96;

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
  await gh.singletonAsync<_i4.Box<_i6.AccountModel>>(
    () => hiveBoxModule.accountBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i7.CategoryModel>>(
    () => hiveBoxModule.categoryBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i8.ExpenseModel>>(
    () => hiveBoxModule.expenseBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<dynamic>>(
    () => hiveBoxModule.boxDynamic,
    instanceName: 'settings',
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i9.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i10.DebtModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  gh.singleton<_i11.CategoryLocalDataManager>(
      _i12.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i7.CategoryModel>>()));
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
      () => _i24.LocalExpenseDataManagerImpl(gh<_i25.Box<_i8.ExpenseModel>>()));
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
  gh.singleton<_i36.ImagePicker>(serviceBoxModule.providesImagePicker());
  gh.singleton<_i37.InAppReview>(serviceBoxModule.providesInAppReview());
  gh.factory<_i38.LocalRecurringDataManager>(() =>
      _i39.LocalRecurringDataManagerImpl(gh<_i4.Box<_i9.RecurringModel>>()));
  gh.singleton<_i40.ProfileRepository>(_i41.ProfileRepositoryImpl(
    gh<_i36.ImagePicker>(),
    gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.singleton<_i42.RecurringRepository>(_i43.RecurringRepositoryImpl(
    gh<_i38.LocalRecurringDataManager>(),
    gh<_i23.ExpenseLocalDataManager>(),
  ));
  gh.factory<_i44.SearchCubit>(
      () => _i44.SearchCubit(gh<_i45.FilterExpenseUseCase>()));
  gh.singleton<_i46.UpdateDebtUseCase>(
      _i46.UpdateDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i47.UpdateExpensesUseCase>(_i47.UpdateExpensesUseCase(
      expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i48.AccountLocalDataManager>(_i49.LocalAccountDataManagerImpl(
      accountBox: gh<_i4.Box<_i6.AccountModel>>()));
  gh.singleton<_i50.AccountRepository>(_i51.AccountRepositoryImpl(
      dataSource: gh<_i48.AccountLocalDataManager>()));
  gh.singleton<_i52.AddAccountUseCase>(
      _i52.AddAccountUseCase(accountRepository: gh<_i50.AccountRepository>()));
  gh.singleton<_i53.AddDebtUseCase>(
      _i53.AddDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i54.AddExpenseUseCase>(
      _i54.AddExpenseUseCase(expenseRepository: gh<_i26.ExpenseRepository>()));
  gh.singleton<_i55.AddRecurringUseCase>(
      _i55.AddRecurringUseCase(gh<_i42.RecurringRepository>()));
  gh.singleton<_i56.AddTransactionUseCase>(
      _i56.AddTransactionUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i57.CategoryRepository>(_i58.CategoryRepositoryImpl(
    dataSources: gh<_i11.CategoryLocalDataManager>(),
    expenseDataManager: gh<_i23.ExpenseLocalDataManager>(),
    settings: gh<_i4.Box<dynamic>>(instanceName: 'settings'),
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
      accountRepository: gh<_i50.AccountRepository>()));
  gh.singleton<_i62.DeleteCategoryUseCase>(_i62.DeleteCategoryUseCase(
      categoryRepository: gh<_i57.CategoryRepository>()));
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
    gh<_i48.AccountLocalDataManager>(),
    gh<_i11.CategoryLocalDataManager>(),
    gh<_i23.ExpenseLocalDataManager>(),
  ));
  gh.singleton<_i67.GetAccountUseCase>(
      _i67.GetAccountUseCase(accountRepository: gh<_i50.AccountRepository>()));
  gh.singleton<_i68.GetAccountsUseCase>(
      _i68.GetAccountsUseCase(accountRepository: gh<_i50.AccountRepository>()));
  gh.singleton<_i69.GetCategoryUseCase>(_i69.GetCategoryUseCase(
      categoryRepository: gh<_i57.CategoryRepository>()));
  gh.singleton<_i70.GetDefaultCategoriesUseCase>(
      _i70.GetDefaultCategoriesUseCase(
          categoryRepository: gh<_i57.CategoryRepository>()));
  gh.factory<_i71.HomeBloc>(() => _i71.HomeBloc(
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
        gh<_i45.GetExpensesUseCase>(),
        gh<_i72.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i73.ImagePickerUseCase>(
      _i73.ImagePickerUseCase(gh<_i40.ProfileRepository>()));
  gh.singleton<_i74.InApp>(_i74.InApp(gh<_i37.InAppReview>()));
  gh.factory<_i75.ProfileCubit>(() => _i75.ProfileCubit(
        gh<_i76.ImagePickerUseCase>(),
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
      ));
  gh.factory<_i77.RecurringCubit>(
      () => _i77.RecurringCubit(gh<_i78.AddRecurringUseCase>()));
  gh.factory<_i79.SettingsRepository>(() => _i80.SettingsRepositoryImpl(
        gh<_i66.FileHandler>(),
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
      ));
  gh.singleton<_i81.SettingsUseCase>(
      _i81.SettingsUseCase(gh<_i79.SettingsRepository>()));
  gh.singleton<_i82.SummaryController>(_i82.SummaryController(
    gh<_i83.SettingsUseCase>(),
    getAccountUseCase: gh<_i84.GetAccountUseCase>(),
    getCategoryUseCase: gh<_i72.GetCategoryUseCase>(),
    getExpensesFromCategoryIdUseCase:
        gh<_i45.GetExpensesFromCategoryIdUseCase>(),
  ));
  gh.factory<_i85.TransactionBloc>(() => _i85.TransactionBloc(
        gh<_i83.SettingsUseCase>(),
        expenseUseCase: gh<_i45.GetExpenseUseCase>(),
        accountUseCase: gh<_i84.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i45.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i45.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i47.UpdateExpensesUseCase>(),
        accountsUseCase: gh<_i84.GetAccountsUseCase>(),
        defaultCategoriesUseCase: gh<_i72.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i86.UpdateAccountUseCase>(_i86.UpdateAccountUseCase(
      accountRepository: gh<_i50.AccountRepository>()));
  gh.singleton<_i87.UpdateCategoryUseCase>(_i87.UpdateCategoryUseCase(
      categoryRepository: gh<_i57.CategoryRepository>()));
  gh.factory<_i88.AccountsBloc>(() => _i88.AccountsBloc(
        getAccountUseCase: gh<_i84.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i84.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i45.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i84.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i84.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i72.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i45.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i84.UpdateAccountUseCase>(),
      ));
  gh.singleton<_i89.AddCategoryUseCase>(_i89.AddCategoryUseCase(
      categoryRepository: gh<_i57.CategoryRepository>()));
  gh.factory<_i90.BudgetCubit>(() => _i90.BudgetCubit(
        gh<_i45.GetExpensesUseCase>(),
        gh<_i72.GetCategoryUseCase>(),
        gh<_i72.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i91.CategoryBloc>(() => _i91.CategoryBloc(
        getCategoryUseCase: gh<_i72.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i72.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i72.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i45.DeleteExpensesFromCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i72.UpdateCategoryUseCase>(),
      ));
  gh.factory<_i92.CountryCubit>(() => _i92.CountryCubit(
        gh<_i29.GetCountriesUseCase>(),
        gh<_i83.SettingsUseCase>(),
      ));
  gh.singleton<_i93.FileExportUseCase>(
      _i93.FileExportUseCase(gh<_i79.SettingsRepository>()));
  gh.singleton<_i94.FileImportUseCase>(
      _i94.FileImportUseCase(gh<_i79.SettingsRepository>()));
  gh.factory<_i95.SettingCubit>(() => _i95.SettingCubit(
        gh<_i45.GetExpensesUseCase>(),
        gh<_i72.GetDefaultCategoriesUseCase>(),
        gh<_i47.UpdateExpensesUseCase>(),
        gh<_i83.FileImportUseCase>(),
        gh<_i83.FileExportUseCase>(),
        gh<_i83.SettingsUseCase>(),
      ));
  return getIt;
}

class _$ServiceBoxModule extends _i96.ServiceBoxModule {}

class _$HiveBoxModule extends _i97.HiveBoxModule {}
