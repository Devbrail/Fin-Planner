// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i21;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i24;
import 'package:image_picker/image_picker.dart' as _i35;
import 'package:in_app_review/in_app_review.dart' as _i36;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/core/in_app.dart' as _i81;
import 'package:paisa/features/account/data/data_sources/local_account_data_manager.dart'
    as _i50;
import 'package:paisa/features/account/data/data_sources/local_account_data_manager_impl.dart'
    as _i51;
import 'package:paisa/features/account/data/model/account_model.dart' as _i7;
import 'package:paisa/features/account/data/repository/account_repository_impl.dart'
    as _i53;
import 'package:paisa/features/account/domain/repository/account_repository.dart'
    as _i52;
import 'package:paisa/features/account/domain/use_case/account_use_case.dart'
    as _i91;
import 'package:paisa/features/account/domain/use_case/add_account_use_case.dart'
    as _i54;
import 'package:paisa/features/account/domain/use_case/delete_account_use_case.dart'
    as _i65;
import 'package:paisa/features/account/domain/use_case/get_account_use_case.dart'
    as _i74;
import 'package:paisa/features/account/domain/use_case/get_accounts_use_case.dart'
    as _i75;
import 'package:paisa/features/account/domain/use_case/update_account_use_case.dart'
    as _i92;
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart'
    as _i94;
import 'package:paisa/features/category/data/data_sources/category_local_data_source.dart'
    as _i11;
import 'package:paisa/features/category/data/data_sources/category_local_data_source_impl.dart'
    as _i12;
import 'package:paisa/features/category/data/model/category_model.dart' as _i6;
import 'package:paisa/features/category/data/repository/category_repository_impl.dart'
    as _i60;
import 'package:paisa/features/category/domain/repository/category_repository.dart'
    as _i59;
import 'package:paisa/features/category/domain/use_case/add_category_use_case.dart'
    as _i95;
import 'package:paisa/features/category/domain/use_case/category_use_case.dart'
    as _i79;
import 'package:paisa/features/category/domain/use_case/delete_category_use_case.dart'
    as _i66;
import 'package:paisa/features/category/domain/use_case/get_category_use_case.dart'
    as _i76;
import 'package:paisa/features/category/domain/use_case/get_default_categories_use_case.dart'
    as _i77;
import 'package:paisa/features/category/domain/use_case/update_category_use_case.dart'
    as _i93;
import 'package:paisa/features/category/presentation/bloc/category_bloc.dart'
    as _i97;
import 'package:paisa/features/currency_picker/data/repository/country_repository_impl.dart'
    as _i14;
import 'package:paisa/features/currency_picker/domain/repository/country_repository.dart'
    as _i13;
import 'package:paisa/features/currency_picker/domain/use_case/get_countries_user_case.dart'
    as _i28;
import 'package:paisa/features/currency_picker/presentation/cubit/country_picker_cubit.dart'
    as _i61;
import 'package:paisa/features/debit/data/data_sources/debit_local_data_source.dart'
    as _i15;
import 'package:paisa/features/debit/data/data_sources/debit_local_data_source_impl.dart'
    as _i16;
import 'package:paisa/features/debit/data/models/debit_model.dart' as _i5;
import 'package:paisa/features/debit/data/models/debit_transactions_model.dart'
    as _i8;
import 'package:paisa/features/debit/data/repository/debit_repository_impl.dart'
    as _i18;
import 'package:paisa/features/debit/domain/repository/debit_repository.dart'
    as _i17;
import 'package:paisa/features/debit/domain/use_case/add_debit_transaction_use_case.dart'
    as _i58;
import 'package:paisa/features/debit/domain/use_case/add_debit_use.case.dart'
    as _i55;
import 'package:paisa/features/debit/domain/use_case/debit_use_case.dart'
    as _i64;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transaction_use_case.dart'
    as _i20;
import 'package:paisa/features/debit/domain/use_case/delete_debit_use_case.dart'
    as _i19;
import 'package:paisa/features/debit/domain/use_case/get_debit_transactions_use_case.dart'
    as _i34;
import 'package:paisa/features/debit/domain/use_case/get_debit_use_case.dart'
    as _i29;
import 'package:paisa/features/debit/domain/use_case/update_debit_use.case.dart'
    as _i48;
import 'package:paisa/features/debit/presentation/cubit/debts_bloc.dart'
    as _i63;
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart'
    as _i78;
import 'package:paisa/features/home/presentation/controller/summary_controller.dart'
    as _i89;
import 'package:paisa/features/home/presentation/cubit/overview/overview_cubit.dart'
    as _i84;
import 'package:paisa/features/profile/data/repository/profile_repository_impl.dart'
    as _i40;
import 'package:paisa/features/profile/domain/repository/profile_repository.dart'
    as _i39;
import 'package:paisa/features/profile/domain/use_case/image_picker_use_case.dart'
    as _i80;
import 'package:paisa/features/profile/domain/use_case/profile_use_case.dart'
    as _i86;
import 'package:paisa/features/profile/presentation/cubit/profile_cubit.dart'
    as _i85;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager.dart'
    as _i37;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager_impl.dart'
    as _i38;
import 'package:paisa/features/recurring/data/model/recurring.dart' as _i10;
import 'package:paisa/features/recurring/data/repository/recurring_repository_impl.dart'
    as _i42;
import 'package:paisa/features/recurring/domain/repository/recurring_repository.dart'
    as _i41;
import 'package:paisa/features/recurring/domain/use_case/add_recurring_use_case.dart'
    as _i57;
import 'package:paisa/features/recurring/domain/use_case/recurring_use_case.dart'
    as _i88;
import 'package:paisa/features/recurring/presentation/cubit/recurring_cubit.dart'
    as _i87;
import 'package:paisa/features/search/presentation/cubit/search_cubit.dart'
    as _i43;
import 'package:paisa/features/settings/data/authenticate.dart' as _i3;
import 'package:paisa/features/settings/data/file_handler.dart' as _i73;
import 'package:paisa/features/settings/data/repository/csv_export_impl.dart'
    as _i72;
import 'package:paisa/features/settings/data/repository/json_export_import_impl.dart'
    as _i71;
import 'package:paisa/features/settings/data/repository/settings_repository_impl.dart'
    as _i46;
import 'package:paisa/features/settings/domain/repository/import_export.dart'
    as _i70;
import 'package:paisa/features/settings/domain/repository/settings_repository.dart'
    as _i45;
import 'package:paisa/features/settings/domain/use_case/csv_file_export_use_case.dart'
    as _i96;
import 'package:paisa/features/settings/domain/use_case/json_file_export_use_case.dart'
    as _i82;
import 'package:paisa/features/settings/domain/use_case/json_file_import_use_case.dart'
    as _i83;
import 'package:paisa/features/settings/domain/use_case/setting_use_case.dart'
    as _i62;
import 'package:paisa/features/settings/domain/use_case/settings_use_case.dart'
    as _i47;
import 'package:paisa/features/settings/presentation/cubit/settings_cubit.dart'
    as _i98;
import 'package:paisa/features/transaction/data/data_sources/local_transaction_data_manager.dart'
    as _i22;
import 'package:paisa/features/transaction/data/data_sources/local_transaction_data_manager_impl.dart'
    as _i23;
import 'package:paisa/features/transaction/data/model/expense_model.dart'
    as _i9;
import 'package:paisa/features/transaction/data/repository/expense_repository_impl.dart'
    as _i26;
import 'package:paisa/features/transaction/domain/repository/expense_repository.dart'
    as _i25;
import 'package:paisa/features/transaction/domain/use_case/add_expenses_use_case.dart'
    as _i56;
import 'package:paisa/features/transaction/domain/use_case/delete_expense_use_case.dart'
    as _i67;
import 'package:paisa/features/transaction/domain/use_case/delete_expenses_from_account_id.dart'
    as _i68;
import 'package:paisa/features/transaction/domain/use_case/delete_expenses_from_category_id.dart'
    as _i69;
import 'package:paisa/features/transaction/domain/use_case/expense_use_case.dart'
    as _i44;
import 'package:paisa/features/transaction/domain/use_case/filter_expense_use_case.dart'
    as _i27;
import 'package:paisa/features/transaction/domain/use_case/get_expense_from_account_id.dart'
    as _i31;
import 'package:paisa/features/transaction/domain/use_case/get_expense_from_category_id.dart'
    as _i32;
import 'package:paisa/features/transaction/domain/use_case/get_expense_use_case.dart'
    as _i30;
import 'package:paisa/features/transaction/domain/use_case/get_expenses_use_case.dart'
    as _i33;
import 'package:paisa/features/transaction/domain/use_case/update_expense_use_case.dart'
    as _i49;
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i90;

import 'module/hive_module.dart' as _i99;
import 'module/service_module.dart' as _i100;

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
  await gh.singletonAsync<_i4.Box<_i5.DebitModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i6.CategoryModel>>(
    () => hiveBoxModule.categoryBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i7.AccountModel>>(
    () => hiveBoxModule.accountBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i8.DebitTransactionsModel>>(
    () => hiveBoxModule.transactionsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i9.TransactionModel>>(
    () => hiveBoxModule.expenseBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i10.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
    preResolve: true,
  );
  gh.singleton<_i11.CategoryLocalDataManager>(
      _i12.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i6.CategoryModel>>()));
  gh.singleton<_i13.CountryRepository>(_i14.CountryRepositoryImpl());
  gh.singleton<_i15.DebtLocalDataSource>(_i16.DebtLocalDataSourceImpl(
    debtBox: gh<_i4.Box<_i5.DebitModel>>(),
    transactionsBox: gh<_i4.Box<_i8.DebitTransactionsModel>>(),
  ));
  gh.singleton<_i17.DebtRepository>(
      _i18.DebtRepositoryImpl(dataSource: gh<_i15.DebtLocalDataSource>()));
  gh.singleton<_i19.DeleteDebtUseCase>(
      _i19.DeleteDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i20.DeleteTransactionUseCase>(
      _i20.DeleteTransactionUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i21.DeviceInfoPlugin>(
      serviceBoxModule.providesDeviceInfoPlugin());
  gh.factory<_i22.ExpenseLocalDataManager>(() =>
      _i23.LocalExpenseDataManagerImpl(gh<_i24.Box<_i9.TransactionModel>>()));
  gh.singleton<_i25.ExpenseRepository>(_i26.ExpenseRepositoryImpl(
      dataSource: gh<_i22.ExpenseLocalDataManager>()));
  gh.singleton<_i27.FilterExpenseUseCase>(
      _i27.FilterExpenseUseCase(gh<_i25.ExpenseRepository>()));
  gh.factory<_i28.GetCountriesUseCase>(
      () => _i28.GetCountriesUseCase(repository: gh<_i13.CountryRepository>()));
  gh.singleton<_i29.GetDebtUseCase>(
      _i29.GetDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i30.GetExpenseUseCase>(
      _i30.GetExpenseUseCase(expenseRepository: gh<_i25.ExpenseRepository>()));
  gh.singleton<_i31.GetExpensesFromAccountIdUseCase>(
      _i31.GetExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i25.ExpenseRepository>()));
  gh.singleton<_i32.GetExpensesFromCategoryIdUseCase>(
      _i32.GetExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i25.ExpenseRepository>()));
  gh.singleton<_i33.GetExpensesUseCase>(
      _i33.GetExpensesUseCase(expenseRepository: gh<_i25.ExpenseRepository>()));
  gh.singleton<_i34.GetTransactionsUseCase>(
      _i34.GetTransactionsUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i35.ImagePicker>(serviceBoxModule.providesImagePicker());
  gh.singleton<_i36.InAppReview>(serviceBoxModule.providesInAppReview());
  gh.factory<_i37.LocalRecurringDataManager>(() =>
      _i38.LocalRecurringDataManagerImpl(gh<_i4.Box<_i10.RecurringModel>>()));
  gh.singleton<_i39.ProfileRepository>(_i40.ProfileRepositoryImpl(
    gh<_i35.ImagePicker>(),
    gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.singleton<_i41.RecurringRepository>(_i42.RecurringRepositoryImpl(
    gh<_i37.LocalRecurringDataManager>(),
    gh<_i22.ExpenseLocalDataManager>(),
  ));
  gh.factory<_i43.SearchCubit>(
      () => _i43.SearchCubit(gh<_i44.FilterExpenseUseCase>()));
  gh.factory<_i45.SettingsRepository>(() => _i46.SettingsRepositoryImpl(
      gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i47.SettingsUseCase>(
      _i47.SettingsUseCase(gh<_i45.SettingsRepository>()));
  gh.singleton<_i48.UpdateDebtUseCase>(
      _i48.UpdateDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i49.UpdateExpensesUseCase>(_i49.UpdateExpensesUseCase(
      expenseRepository: gh<_i25.ExpenseRepository>()));
  gh.singleton<_i50.AccountLocalDataManager>(_i51.LocalAccountDataManagerImpl(
      accountBox: gh<_i4.Box<_i7.AccountModel>>()));
  gh.singleton<_i52.AccountRepository>(_i53.AccountRepositoryImpl(
      dataSource: gh<_i50.AccountLocalDataManager>()));
  gh.singleton<_i54.AddAccountUseCase>(
      _i54.AddAccountUseCase(accountRepository: gh<_i52.AccountRepository>()));
  gh.singleton<_i55.AddDebtUseCase>(
      _i55.AddDebtUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i56.AddExpenseUseCase>(
      _i56.AddExpenseUseCase(expenseRepository: gh<_i25.ExpenseRepository>()));
  gh.singleton<_i57.AddRecurringUseCase>(
      _i57.AddRecurringUseCase(gh<_i41.RecurringRepository>()));
  gh.singleton<_i58.AddTransactionUseCase>(
      _i58.AddTransactionUseCase(debtRepository: gh<_i17.DebtRepository>()));
  gh.singleton<_i59.CategoryRepository>(_i60.CategoryRepositoryImpl(
    dataSources: gh<_i11.CategoryLocalDataManager>(),
    expenseDataManager: gh<_i22.ExpenseLocalDataManager>(),
    settings: gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.factory<_i61.CountryPickerCubit>(() => _i61.CountryPickerCubit(
        gh<_i28.GetCountriesUseCase>(),
        gh<_i62.SettingsUseCase>(),
      ));
  gh.factory<_i63.DebtsBloc>(() => _i63.DebtsBloc(
        addDebtUseCase: gh<_i64.AddDebtUseCase>(),
        getDebtUseCase: gh<_i64.GetDebtUseCase>(),
        getTransactionsUseCase: gh<_i64.GetTransactionsUseCase>(),
        addTransactionUseCase: gh<_i64.AddTransactionUseCase>(),
        updateDebtUseCase: gh<_i64.UpdateDebtUseCase>(),
        deleteDebtUseCase: gh<_i64.DeleteDebtUseCase>(),
        deleteTransactionUseCase: gh<_i64.DeleteTransactionUseCase>(),
      ));
  gh.singleton<_i65.DeleteAccountUseCase>(_i65.DeleteAccountUseCase(
      accountRepository: gh<_i52.AccountRepository>()));
  gh.singleton<_i66.DeleteCategoryUseCase>(_i66.DeleteCategoryUseCase(
      categoryRepository: gh<_i59.CategoryRepository>()));
  gh.singleton<_i67.DeleteExpenseUseCase>(_i67.DeleteExpenseUseCase(
      expenseRepository: gh<_i25.ExpenseRepository>()));
  gh.singleton<_i68.DeleteExpensesFromAccountIdUseCase>(
      _i68.DeleteExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i25.ExpenseRepository>()));
  gh.singleton<_i69.DeleteExpensesFromCategoryIdUseCase>(
      _i69.DeleteExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i25.ExpenseRepository>()));
  gh.lazySingleton<_i70.Export>(
    () => _i71.JSONExportImpl(
      gh<_i50.AccountLocalDataManager>(),
      gh<_i11.CategoryLocalDataManager>(),
      gh<_i22.ExpenseLocalDataManager>(),
    ),
    instanceName: 'json_export',
  );
  gh.lazySingleton<_i70.Export>(
    () => _i72.CSVExport(
      gh<_i21.DeviceInfoPlugin>(),
      gh<_i50.AccountLocalDataManager>(),
      gh<_i11.CategoryLocalDataManager>(),
      gh<_i22.ExpenseLocalDataManager>(),
    ),
    instanceName: 'csv',
  );
  gh.singleton<_i73.FileHandler>(_i73.FileHandler(
    gh<_i21.DeviceInfoPlugin>(),
    gh<_i50.AccountLocalDataManager>(),
    gh<_i11.CategoryLocalDataManager>(),
    gh<_i22.ExpenseLocalDataManager>(),
  ));
  gh.singleton<_i74.GetAccountUseCase>(
      _i74.GetAccountUseCase(accountRepository: gh<_i52.AccountRepository>()));
  gh.singleton<_i75.GetAccountsUseCase>(
      _i75.GetAccountsUseCase(accountRepository: gh<_i52.AccountRepository>()));
  gh.singleton<_i76.GetCategoryUseCase>(_i76.GetCategoryUseCase(
      categoryRepository: gh<_i59.CategoryRepository>()));
  gh.singleton<_i77.GetDefaultCategoriesUseCase>(
      _i77.GetDefaultCategoriesUseCase(
          categoryRepository: gh<_i59.CategoryRepository>()));
  gh.factory<_i78.HomeBloc>(() => _i78.HomeBloc(
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
        gh<_i44.GetExpensesUseCase>(),
        gh<_i79.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i80.ImagePickerUseCase>(
      _i80.ImagePickerUseCase(gh<_i39.ProfileRepository>()));
  gh.lazySingleton<_i70.Import>(
    () => _i71.JSONImportImpl(
      gh<_i21.DeviceInfoPlugin>(),
      gh<_i50.AccountLocalDataManager>(),
      gh<_i11.CategoryLocalDataManager>(),
      gh<_i22.ExpenseLocalDataManager>(),
    ),
    instanceName: 'json_import',
  );
  gh.singleton<_i81.InApp>(_i81.InApp(gh<_i36.InAppReview>()));
  gh.singleton<_i82.JSONFileExportUseCase>(_i82.JSONFileExportUseCase(
    gh<_i45.SettingsRepository>(),
    gh<_i70.Export>(instanceName: 'json_export'),
  ));
  gh.singleton<_i83.JSONFileImportUseCase>(_i83.JSONFileImportUseCase(
    gh<_i45.SettingsRepository>(),
    gh<_i70.Import>(instanceName: 'json_import'),
  ));
  gh.factory<_i84.OverviewCubit>(() => _i84.OverviewCubit(
        gh<_i44.GetExpensesUseCase>(),
        gh<_i79.GetCategoryUseCase>(),
        gh<_i79.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i85.ProfileCubit>(() => _i85.ProfileCubit(
        gh<_i86.ImagePickerUseCase>(),
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
      ));
  gh.factory<_i87.RecurringCubit>(
      () => _i87.RecurringCubit(gh<_i88.AddRecurringUseCase>()));
  gh.singleton<_i89.SummaryController>(_i89.SummaryController(
    gh<_i62.SettingsUseCase>(),
    getAccountUseCase: gh<_i74.GetAccountUseCase>(),
    getCategoryUseCase: gh<_i79.GetCategoryUseCase>(),
    getExpensesFromCategoryIdUseCase:
        gh<_i44.GetExpensesFromCategoryIdUseCase>(),
  ));
  gh.factory<_i90.TransactionBloc>(() => _i90.TransactionBloc(
        gh<_i47.SettingsUseCase>(),
        expenseUseCase: gh<_i44.GetExpenseUseCase>(),
        accountUseCase: gh<_i91.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i44.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i44.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i44.UpdateExpensesUseCase>(),
        accountsUseCase: gh<_i91.GetAccountsUseCase>(),
        defaultCategoriesUseCase: gh<_i79.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i92.UpdateAccountUseCase>(_i92.UpdateAccountUseCase(
      accountRepository: gh<_i52.AccountRepository>()));
  gh.singleton<_i93.UpdateCategoryUseCase>(_i93.UpdateCategoryUseCase(
      categoryRepository: gh<_i59.CategoryRepository>()));
  gh.factory<_i94.AccountsBloc>(() => _i94.AccountsBloc(
        getAccountUseCase: gh<_i91.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i91.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i44.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i91.AddAccountUseCase>(),
        getAccountsUseCase: gh<_i91.GetAccountsUseCase>(),
        getCategoryUseCase: gh<_i76.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i44.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i91.UpdateAccountUseCase>(),
      ));
  gh.singleton<_i95.AddCategoryUseCase>(_i95.AddCategoryUseCase(
      categoryRepository: gh<_i59.CategoryRepository>()));
  gh.singleton<_i96.CSVFileExportUseCase>(_i96.CSVFileExportUseCase(
    gh<_i45.SettingsRepository>(),
    gh<_i70.Export>(instanceName: 'csv'),
  ));
  gh.factory<_i97.CategoryBloc>(() => _i97.CategoryBloc(
        getCategoryUseCase: gh<_i79.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i79.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i79.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i44.DeleteExpensesFromCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i79.UpdateCategoryUseCase>(),
      ));
  gh.factory<_i98.SettingCubit>(() => _i98.SettingCubit(
        gh<_i44.GetExpensesUseCase>(),
        gh<_i79.GetDefaultCategoriesUseCase>(),
        gh<_i44.UpdateExpensesUseCase>(),
        gh<_i62.JSONFileImportUseCase>(),
        gh<_i62.JSONFileExportUseCase>(),
        gh<_i62.SettingsUseCase>(),
        gh<_i62.CSVFileExportUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i99.HiveBoxModule {}

class _$ServiceBoxModule extends _i100.ServiceBoxModule {}
