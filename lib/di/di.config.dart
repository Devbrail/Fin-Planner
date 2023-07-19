// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i23;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i7;
import 'package:hive_flutter/hive_flutter.dart' as _i26;
import 'package:image_picker/image_picker.dart' as _i43;
import 'package:in_app_review/in_app_review.dart' as _i44;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/core/in_app.dart' as _i81;
import 'package:paisa/features/account/data/data_sources/local_account_data_manager_impl.dart'
    as _i45;
import 'package:paisa/features/account/data/model/account_model.dart' as _i12;
import 'package:paisa/features/account/data/repository/account_repository_impl.dart'
    as _i4;
import 'package:paisa/features/account/domain/repository/account_repository.dart'
    as _i3;
import 'package:paisa/features/account/domain/use_case/account_use_case.dart'
    as _i92;
import 'package:paisa/features/account/domain/use_case/add_account_use_case.dart'
    as _i5;
import 'package:paisa/features/account/domain/use_case/delete_account_use_case.dart'
    as _i20;
import 'package:paisa/features/account/domain/use_case/get_account_use_case.dart'
    as _i34;
import 'package:paisa/features/account/domain/use_case/get_accounts_use_case.dart'
    as _i35;
import 'package:paisa/features/account/domain/use_case/update_account_use_case.dart'
    as _i58;
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart'
    as _i94;
import 'package:paisa/features/category/data/data_sources/category_local_data_source_impl.dart'
    as _i46;
import 'package:paisa/features/category/data/model/category_model.dart' as _i11;
import 'package:paisa/features/category/data/repository/category_repository_impl.dart'
    as _i67;
import 'package:paisa/features/category/domain/repository/category_repository.dart'
    as _i66;
import 'package:paisa/features/category/domain/use_case/add_category_use_case.dart'
    as _i95;
import 'package:paisa/features/category/domain/use_case/category_use_case.dart'
    as _i79;
import 'package:paisa/features/category/domain/use_case/delete_category_use_case.dart'
    as _i72;
import 'package:paisa/features/category/domain/use_case/get_category_use_case.dart'
    as _i76;
import 'package:paisa/features/category/domain/use_case/get_default_categories_use_case.dart'
    as _i77;
import 'package:paisa/features/category/domain/use_case/update_category_use_case.dart'
    as _i93;
import 'package:paisa/features/category/presentation/bloc/category_bloc.dart'
    as _i96;
import 'package:paisa/features/currency_picker/data/repository/country_repository_impl.dart'
    as _i15;
import 'package:paisa/features/currency_picker/domain/repository/country_repository.dart'
    as _i14;
import 'package:paisa/features/currency_picker/domain/use_case/get_countries_user_case.dart'
    as _i36;
import 'package:paisa/features/currency_picker/presentation/cubit/country_picker_cubit.dart'
    as _i68;
import 'package:paisa/features/debit/data/data_sources/debit_local_data_source.dart'
    as _i16;
import 'package:paisa/features/debit/data/data_sources/debit_local_data_source_impl.dart'
    as _i17;
import 'package:paisa/features/debit/data/models/debit_model.dart' as _i10;
import 'package:paisa/features/debit/data/models/debit_transactions_model.dart'
    as _i9;
import 'package:paisa/features/debit/data/repository/debit_repository_impl.dart'
    as _i19;
import 'package:paisa/features/debit/domain/repository/debit_repository.dart'
    as _i18;
import 'package:paisa/features/debit/domain/use_case/add_debit_transaction_use_case.dart'
    as _i64;
import 'package:paisa/features/debit/domain/use_case/add_debit_use.case.dart'
    as _i61;
import 'package:paisa/features/debit/domain/use_case/debit_use_case.dart'
    as _i71;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transaction_use_case.dart'
    as _i22;
import 'package:paisa/features/debit/domain/use_case/delete_debit_use_case.dart'
    as _i21;
import 'package:paisa/features/debit/domain/use_case/get_debit_transactions_use_case.dart'
    as _i42;
import 'package:paisa/features/debit/domain/use_case/get_debit_use_case.dart'
    as _i37;
import 'package:paisa/features/debit/domain/use_case/update_debit_use.case.dart'
    as _i59;
import 'package:paisa/features/debit/presentation/cubit/debts_bloc.dart'
    as _i70;
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart'
    as _i78;
import 'package:paisa/features/home/presentation/controller/summary_controller.dart'
    as _i90;
import 'package:paisa/features/home/presentation/cubit/overview/overview_cubit.dart'
    as _i84;
import 'package:paisa/features/profile/data/repository/profile_repository_impl.dart'
    as _i50;
import 'package:paisa/features/profile/domain/repository/profile_repository.dart'
    as _i49;
import 'package:paisa/features/profile/domain/use_case/image_picker_use_case.dart'
    as _i80;
import 'package:paisa/features/profile/domain/use_case/profile_use_case.dart'
    as _i86;
import 'package:paisa/features/profile/presentation/cubit/profile_cubit.dart'
    as _i85;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager.dart'
    as _i47;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager_impl.dart'
    as _i48;
import 'package:paisa/features/recurring/data/model/recurring.dart' as _i8;
import 'package:paisa/features/recurring/data/repository/recurring_repository_impl.dart'
    as _i52;
import 'package:paisa/features/recurring/domain/repository/recurring_repository.dart'
    as _i51;
import 'package:paisa/features/recurring/domain/use_case/add_recurring_use_case.dart'
    as _i63;
import 'package:paisa/features/recurring/domain/use_case/recurring_use_case.dart'
    as _i88;
import 'package:paisa/features/recurring/presentation/cubit/recurring_cubit.dart'
    as _i87;
import 'package:paisa/features/search/presentation/cubit/search_cubit.dart'
    as _i53;
import 'package:paisa/features/settings/data/authenticate.dart' as _i6;
import 'package:paisa/features/settings/data/file_handler.dart' as _i32;
import 'package:paisa/features/settings/data/repository/csv_export_impl.dart'
    as _i31;
import 'package:paisa/features/settings/data/repository/json_export_import_impl.dart'
    as _i30;
import 'package:paisa/features/settings/data/repository/settings_repository_impl.dart'
    as _i56;
import 'package:paisa/features/settings/domain/repository/import_export.dart'
    as _i29;
import 'package:paisa/features/settings/domain/repository/settings_repository.dart'
    as _i55;
import 'package:paisa/features/settings/domain/use_case/csv_file_export_use_case.dart'
    as _i65;
import 'package:paisa/features/settings/domain/use_case/json_file_export_use_case.dart'
    as _i82;
import 'package:paisa/features/settings/domain/use_case/json_file_import_use_case.dart'
    as _i83;
import 'package:paisa/features/settings/domain/use_case/setting_use_case.dart'
    as _i69;
import 'package:paisa/features/settings/domain/use_case/settings_use_case.dart'
    as _i57;
import 'package:paisa/features/settings/presentation/cubit/settings_cubit.dart'
    as _i89;
import 'package:paisa/features/transaction/data/data_sources/local_transaction_data_manager.dart'
    as _i24;
import 'package:paisa/features/transaction/data/data_sources/local_transaction_data_manager_impl.dart'
    as _i25;
import 'package:paisa/features/transaction/data/model/expense_model.dart'
    as _i13;
import 'package:paisa/features/transaction/data/repository/expense_repository_impl.dart'
    as _i28;
import 'package:paisa/features/transaction/domain/repository/expense_repository.dart'
    as _i27;
import 'package:paisa/features/transaction/domain/use_case/add_expenses_use_case.dart'
    as _i62;
import 'package:paisa/features/transaction/domain/use_case/delete_expense_use_case.dart'
    as _i73;
import 'package:paisa/features/transaction/domain/use_case/delete_expenses_from_account_id.dart'
    as _i74;
import 'package:paisa/features/transaction/domain/use_case/delete_expenses_from_category_id.dart'
    as _i75;
import 'package:paisa/features/transaction/domain/use_case/expense_use_case.dart'
    as _i54;
import 'package:paisa/features/transaction/domain/use_case/filter_expense_use_case.dart'
    as _i33;
import 'package:paisa/features/transaction/domain/use_case/get_expense_from_account_id.dart'
    as _i39;
import 'package:paisa/features/transaction/domain/use_case/get_expense_from_category_id.dart'
    as _i40;
import 'package:paisa/features/transaction/domain/use_case/get_expense_use_case.dart'
    as _i38;
import 'package:paisa/features/transaction/domain/use_case/get_expenses_use_case.dart'
    as _i41;
import 'package:paisa/features/transaction/domain/use_case/update_expense_use_case.dart'
    as _i60;
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i91;

import 'module/hive_module.dart' as _i97;
import 'module/service_module.dart' as _i98;

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
  gh.singleton<_i3.AccountRepository>(
      _i4.AccountRepositoryImpl(dataSource: gh<dynamic>()));
  gh.singleton<_i5.AddAccountUseCase>(
      _i5.AddAccountUseCase(accountRepository: gh<_i3.AccountRepository>()));
  gh.singleton<_i6.Authenticate>(_i6.Authenticate());
  await gh.singletonAsync<_i7.Box<dynamic>>(
    () => hiveBoxModule.boxDynamic,
    instanceName: 'settings',
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i8.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i9.DebitTransactionsModel>>(
    () => hiveBoxModule.transactionsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i10.DebitModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i11.CategoryModel>>(
    () => hiveBoxModule.categoryBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i12.AccountModel>>(
    () => hiveBoxModule.accountBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i7.Box<_i13.TransactionModel>>(
    () => hiveBoxModule.expenseBox,
    preResolve: true,
  );
  gh.singleton<_i14.CountryRepository>(_i15.CountryRepositoryImpl());
  gh.singleton<_i16.DebtLocalDataSource>(_i17.DebtLocalDataSourceImpl(
    debtBox: gh<_i7.Box<_i10.DebitModel>>(),
    transactionsBox: gh<_i7.Box<_i9.DebitTransactionsModel>>(),
  ));
  gh.singleton<_i18.DebtRepository>(
      _i19.DebtRepositoryImpl(dataSource: gh<_i16.DebtLocalDataSource>()));
  gh.singleton<_i20.DeleteAccountUseCase>(_i20.DeleteAccountUseCase(
      accountRepository: gh<_i3.AccountRepository>()));
  gh.singleton<_i21.DeleteDebtUseCase>(
      _i21.DeleteDebtUseCase(debtRepository: gh<_i18.DebtRepository>()));
  gh.singleton<_i22.DeleteTransactionUseCase>(
      _i22.DeleteTransactionUseCase(debtRepository: gh<_i18.DebtRepository>()));
  gh.singleton<_i23.DeviceInfoPlugin>(
      serviceBoxModule.providesDeviceInfoPlugin());
  gh.factory<_i24.ExpenseLocalDataManager>(() =>
      _i25.LocalExpenseDataManagerImpl(gh<_i26.Box<_i13.TransactionModel>>()));
  gh.singleton<_i27.ExpenseRepository>(_i28.ExpenseRepositoryImpl(
      dataSource: gh<_i24.ExpenseLocalDataManager>()));
  gh.lazySingleton<_i29.Export>(
    () => _i30.JSONExportImpl(
      gh<dynamic>(),
      gh<dynamic>(),
      gh<_i24.ExpenseLocalDataManager>(),
    ),
    instanceName: 'json_export',
  );
  gh.lazySingleton<_i29.Export>(
    () => _i31.CSVExport(
      gh<_i23.DeviceInfoPlugin>(),
      gh<dynamic>(),
      gh<dynamic>(),
      gh<_i24.ExpenseLocalDataManager>(),
    ),
    instanceName: 'csv',
  );
  gh.singleton<_i32.FileHandler>(_i32.FileHandler(
    gh<_i23.DeviceInfoPlugin>(),
    gh<dynamic>(),
    gh<dynamic>(),
    gh<_i24.ExpenseLocalDataManager>(),
  ));
  gh.singleton<_i33.FilterExpenseUseCase>(
      _i33.FilterExpenseUseCase(gh<_i27.ExpenseRepository>()));
  gh.singleton<_i34.GetAccountUseCase>(
      _i34.GetAccountUseCase(accountRepository: gh<_i3.AccountRepository>()));
  gh.singleton<_i35.GetAccountsUseCase>(
      _i35.GetAccountsUseCase(accountRepository: gh<_i3.AccountRepository>()));
  gh.factory<_i36.GetCountriesUseCase>(
      () => _i36.GetCountriesUseCase(repository: gh<_i14.CountryRepository>()));
  gh.singleton<_i37.GetDebtUseCase>(
      _i37.GetDebtUseCase(debtRepository: gh<_i18.DebtRepository>()));
  gh.singleton<_i38.GetExpenseUseCase>(
      _i38.GetExpenseUseCase(expenseRepository: gh<_i27.ExpenseRepository>()));
  gh.singleton<_i39.GetExpensesFromAccountIdUseCase>(
      _i39.GetExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i27.ExpenseRepository>()));
  gh.singleton<_i40.GetExpensesFromCategoryIdUseCase>(
      _i40.GetExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i27.ExpenseRepository>()));
  gh.singleton<_i41.GetExpensesUseCase>(
      _i41.GetExpensesUseCase(expenseRepository: gh<_i27.ExpenseRepository>()));
  gh.singleton<_i42.GetTransactionsUseCase>(
      _i42.GetTransactionsUseCase(debtRepository: gh<_i18.DebtRepository>()));
  gh.singleton<_i43.ImagePicker>(serviceBoxModule.providesImagePicker());
  gh.lazySingleton<_i29.Import>(
    () => _i30.JSONImportImpl(
      gh<_i23.DeviceInfoPlugin>(),
      gh<dynamic>(),
      gh<dynamic>(),
      gh<_i24.ExpenseLocalDataManager>(),
    ),
    instanceName: 'json_import',
  );
  gh.singleton<_i44.InAppReview>(serviceBoxModule.providesInAppReview());
  gh.singleton<_i45.LocalAccountDataManagerImpl>(
      _i45.LocalAccountDataManagerImpl(
          accountBox: gh<_i7.Box<_i12.AccountModel>>()));
  gh.singleton<_i46.LocalCategoryManagerDataSourceImpl>(
      _i46.LocalCategoryManagerDataSourceImpl(
          gh<_i7.Box<_i11.CategoryModel>>()));
  gh.factory<_i47.LocalRecurringDataManager>(() =>
      _i48.LocalRecurringDataManagerImpl(gh<_i7.Box<_i8.RecurringModel>>()));
  gh.singleton<_i49.ProfileRepository>(_i50.ProfileRepositoryImpl(
    gh<_i43.ImagePicker>(),
    gh<_i7.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.singleton<_i51.RecurringRepository>(_i52.RecurringRepositoryImpl(
    gh<_i47.LocalRecurringDataManager>(),
    gh<_i24.ExpenseLocalDataManager>(),
  ));
  gh.factory<_i53.SearchCubit>(
      () => _i53.SearchCubit(gh<_i54.FilterExpenseUseCase>()));
  gh.factory<_i55.SettingsRepository>(() => _i56.SettingsRepositoryImpl(
      gh<_i7.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i57.SettingsUseCase>(
      _i57.SettingsUseCase(gh<_i55.SettingsRepository>()));
  gh.singleton<_i58.UpdateAccountUseCase>(_i58.UpdateAccountUseCase(
      accountRepository: gh<_i3.AccountRepository>()));
  gh.singleton<_i59.UpdateDebtUseCase>(
      _i59.UpdateDebtUseCase(debtRepository: gh<_i18.DebtRepository>()));
  gh.singleton<_i60.UpdateExpensesUseCase>(_i60.UpdateExpensesUseCase(
      expenseRepository: gh<_i27.ExpenseRepository>()));
  gh.singleton<_i61.AddDebtUseCase>(
      _i61.AddDebtUseCase(debtRepository: gh<_i18.DebtRepository>()));
  gh.singleton<_i62.AddExpenseUseCase>(
      _i62.AddExpenseUseCase(expenseRepository: gh<_i27.ExpenseRepository>()));
  gh.singleton<_i63.AddRecurringUseCase>(
      _i63.AddRecurringUseCase(gh<_i51.RecurringRepository>()));
  gh.singleton<_i64.AddTransactionUseCase>(
      _i64.AddTransactionUseCase(debtRepository: gh<_i18.DebtRepository>()));
  gh.singleton<_i65.CSVFileExportUseCase>(_i65.CSVFileExportUseCase(
    gh<_i55.SettingsRepository>(),
    gh<_i29.Export>(instanceName: 'csv'),
  ));
  gh.singleton<_i66.CategoryRepository>(_i67.CategoryRepositoryImpl(
    dataSources: gh<dynamic>(),
    expenseDataManager: gh<_i24.ExpenseLocalDataManager>(),
    settings: gh<_i7.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.factory<_i68.CountryPickerCubit>(() => _i68.CountryPickerCubit(
        gh<_i36.GetCountriesUseCase>(),
        gh<_i69.SettingsUseCase>(),
      ));
  gh.factory<_i70.DebtsBloc>(() => _i70.DebtsBloc(
        addDebtUseCase: gh<_i71.AddDebtUseCase>(),
        getDebtUseCase: gh<_i71.GetDebtUseCase>(),
        getTransactionsUseCase: gh<_i71.GetTransactionsUseCase>(),
        addTransactionUseCase: gh<_i71.AddTransactionUseCase>(),
        updateDebtUseCase: gh<_i71.UpdateDebtUseCase>(),
        deleteDebtUseCase: gh<_i71.DeleteDebtUseCase>(),
        deleteTransactionUseCase: gh<_i71.DeleteTransactionUseCase>(),
      ));
  gh.singleton<_i72.DeleteCategoryUseCase>(_i72.DeleteCategoryUseCase(
      categoryRepository: gh<_i66.CategoryRepository>()));
  gh.singleton<_i73.DeleteExpenseUseCase>(_i73.DeleteExpenseUseCase(
      expenseRepository: gh<_i27.ExpenseRepository>()));
  gh.singleton<_i74.DeleteExpensesFromAccountIdUseCase>(
      _i74.DeleteExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i27.ExpenseRepository>()));
  gh.singleton<_i75.DeleteExpensesFromCategoryIdUseCase>(
      _i75.DeleteExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i27.ExpenseRepository>()));
  gh.singleton<_i76.GetCategoryUseCase>(_i76.GetCategoryUseCase(
      categoryRepository: gh<_i66.CategoryRepository>()));
  gh.singleton<_i77.GetDefaultCategoriesUseCase>(
      _i77.GetDefaultCategoriesUseCase(
          categoryRepository: gh<_i66.CategoryRepository>()));
  gh.factory<_i78.HomeBloc>(() => _i78.HomeBloc(
        gh<_i7.Box<dynamic>>(instanceName: 'settings'),
        gh<_i54.GetExpensesUseCase>(),
        gh<_i79.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i80.ImagePickerUseCase>(
      _i80.ImagePickerUseCase(gh<_i49.ProfileRepository>()));
  gh.singleton<_i81.InApp>(_i81.InApp(gh<_i44.InAppReview>()));
  gh.singleton<_i82.JSONFileExportUseCase>(_i82.JSONFileExportUseCase(
    gh<_i55.SettingsRepository>(),
    gh<_i29.Export>(instanceName: 'json_export'),
  ));
  gh.singleton<_i83.JSONFileImportUseCase>(_i83.JSONFileImportUseCase(
    gh<_i55.SettingsRepository>(),
    gh<_i29.Import>(instanceName: 'json_import'),
  ));
  gh.factory<_i84.OverviewCubit>(() => _i84.OverviewCubit(
        gh<_i54.GetExpensesUseCase>(),
        gh<_i79.GetCategoryUseCase>(),
        gh<_i79.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i85.ProfileCubit>(() => _i85.ProfileCubit(
        gh<_i86.ImagePickerUseCase>(),
        gh<_i7.Box<dynamic>>(instanceName: 'settings'),
      ));
  gh.factory<_i87.RecurringCubit>(
      () => _i87.RecurringCubit(gh<_i88.AddRecurringUseCase>()));
  gh.factory<_i89.SettingCubit>(() => _i89.SettingCubit(
        gh<_i54.GetExpensesUseCase>(),
        gh<_i79.GetDefaultCategoriesUseCase>(),
        gh<_i54.UpdateExpensesUseCase>(),
        gh<_i69.JSONFileImportUseCase>(),
        gh<_i69.JSONFileExportUseCase>(),
        gh<_i69.SettingsUseCase>(),
        gh<_i69.CSVFileExportUseCase>(),
      ));
  gh.singleton<_i90.SummaryController>(_i90.SummaryController(
    gh<_i69.SettingsUseCase>(),
    getAccountUseCase: gh<_i34.GetAccountUseCase>(),
    getCategoryUseCase: gh<_i79.GetCategoryUseCase>(),
    getExpensesFromCategoryIdUseCase:
        gh<_i54.GetExpensesFromCategoryIdUseCase>(),
  ));
  gh.factory<_i91.TransactionBloc>(() => _i91.TransactionBloc(
        gh<_i57.SettingsUseCase>(),
        expenseUseCase: gh<_i54.GetExpenseUseCase>(),
        accountUseCase: gh<_i92.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i54.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i54.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i54.UpdateExpensesUseCase>(),
        accountsUseCase: gh<_i92.GetAccountsUseCase>(),
        defaultCategoriesUseCase: gh<_i79.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i93.UpdateCategoryUseCase>(_i93.UpdateCategoryUseCase(
      categoryRepository: gh<_i66.CategoryRepository>()));
  gh.factory<_i94.AccountsBloc>(() => _i94.AccountsBloc(
        getAccountUseCase: gh<_i92.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i92.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i54.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i92.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i92.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i76.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i54.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i92.UpdateAccountUseCase>(),
      ));
  gh.singleton<_i95.AddCategoryUseCase>(_i95.AddCategoryUseCase(
      categoryRepository: gh<_i66.CategoryRepository>()));
  gh.factory<_i96.CategoryBloc>(() => _i96.CategoryBloc(
        getCategoryUseCase: gh<_i79.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i79.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i79.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i54.DeleteExpensesFromCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i79.UpdateCategoryUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i97.HiveBoxModule {}

class _$ServiceBoxModule extends _i98.ServiceBoxModule {}
