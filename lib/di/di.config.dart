// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i16;
import 'package:image_picker/image_picker.dart' as _i25;
import 'package:in_app_review/in_app_review.dart' as _i26;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/core/in_app.dart' as _i76;
import 'package:paisa/features/account/data/data_sources/local/account_data_manager.dart'
    as _i27;
import 'package:paisa/features/account/data/model/account_model.dart' as _i6;
import 'package:paisa/features/account/data/repository/account_repository_impl.dart'
    as _i45;
import 'package:paisa/features/account/domain/repository/account_repository.dart'
    as _i44;
import 'package:paisa/features/account/domain/use_case/account_use_case.dart'
    as _i74;
import 'package:paisa/features/account/domain/use_case/add_account_use_case.dart'
    as _i46;
import 'package:paisa/features/account/domain/use_case/delete_account_use_case.dart'
    as _i54;
import 'package:paisa/features/account/domain/use_case/get_account_use_case.dart'
    as _i66;
import 'package:paisa/features/account/domain/use_case/get_accounts_use_case.dart'
    as _i67;
import 'package:paisa/features/account/domain/use_case/update_account_use_case.dart'
    as _i85;
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart'
    as _i88;
import 'package:paisa/features/category/data/data_sources/local/category_data_source.dart'
    as _i28;
import 'package:paisa/features/category/data/model/category_model.dart' as _i7;
import 'package:paisa/features/category/data/repository/category_repository_impl.dart'
    as _i50;
import 'package:paisa/features/category/domain/repository/category_repository.dart'
    as _i49;
import 'package:paisa/features/category/domain/use_case/add_category_use_case.dart'
    as _i89;
import 'package:paisa/features/category/domain/use_case/category_use_case.dart'
    as _i73;
import 'package:paisa/features/category/domain/use_case/delete_category_use_case.dart'
    as _i55;
import 'package:paisa/features/category/domain/use_case/get_category_use_case.dart'
    as _i68;
import 'package:paisa/features/category/domain/use_case/get_default_categories_use_case.dart'
    as _i71;
import 'package:paisa/features/category/domain/use_case/update_category_use_case.dart'
    as _i86;
import 'package:paisa/features/category/presentation/bloc/category_bloc.dart'
    as _i93;
import 'package:paisa/features/country_picker/data/repository/country_repository_impl.dart'
    as _i12;
import 'package:paisa/features/country_picker/domain/repository/country_repository.dart'
    as _i11;
import 'package:paisa/features/country_picker/domain/use_case/get_contries_user_case.dart'
    as _i20;
import 'package:paisa/features/country_picker/presentation/cubit/country_picker_cubit.dart'
    as _i51;
import 'package:paisa/features/debit/data/data_sources/local/debit_local_data_source_impl.dart'
    as _i29;
import 'package:paisa/features/debit/data/models/debit_model.dart' as _i9;
import 'package:paisa/features/debit/data/models/debit_transactions_model.dart'
    as _i10;
import 'package:paisa/features/debit/data/repository/debit_repository_impl.dart'
    as _i53;
import 'package:paisa/features/debit/domain/repository/debit_repository.dart'
    as _i52;
import 'package:paisa/features/debit/domain/use_case/add_debit_transaction_use_case.dart'
    as _i91;
import 'package:paisa/features/debit/domain/use_case/add_debit_use.case.dart'
    as _i90;
import 'package:paisa/features/debit/domain/use_case/debit_use_case.dart'
    as _i95;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transaction_use_case.dart'
    as _i56;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transactions_by_debit_id_use_case.dart'
    as _i57;
import 'package:paisa/features/debit/domain/use_case/delete_debit_use_case.dart'
    as _i58;
import 'package:paisa/features/debit/domain/use_case/get_debit_transactions_use_case.dart'
    as _i69;
import 'package:paisa/features/debit/domain/use_case/get_debit_use_case.dart'
    as _i70;
import 'package:paisa/features/debit/domain/use_case/update_debit_use.case.dart'
    as _i87;
import 'package:paisa/features/debit/presentation/cubit/debts_bloc.dart'
    as _i94;
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart'
    as _i72;
import 'package:paisa/features/home/presentation/controller/summary_controller.dart'
    as _i41;
import 'package:paisa/features/home/presentation/cubit/overview/overview_cubit.dart'
    as _i79;
import 'package:paisa/features/profile/data/repository/profile_repository_impl.dart'
    as _i33;
import 'package:paisa/features/profile/domain/repository/profile_repository.dart'
    as _i32;
import 'package:paisa/features/profile/domain/use_case/image_picker_use_case.dart'
    as _i75;
import 'package:paisa/features/profile/domain/use_case/profile_use_case.dart'
    as _i81;
import 'package:paisa/features/profile/presentation/cubit/profile_cubit.dart'
    as _i80;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager.dart'
    as _i30;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager_impl.dart'
    as _i31;
import 'package:paisa/features/recurring/data/model/recurring.dart' as _i8;
import 'package:paisa/features/recurring/data/repository/recurring_repository_impl.dart'
    as _i35;
import 'package:paisa/features/recurring/domain/repository/recurring_repository.dart'
    as _i34;
import 'package:paisa/features/recurring/domain/use_case/add_recurring_use_case.dart'
    as _i48;
import 'package:paisa/features/recurring/domain/use_case/recurring_use_case.dart'
    as _i83;
import 'package:paisa/features/recurring/presentation/cubit/recurring_cubit.dart'
    as _i82;
import 'package:paisa/features/search/presentation/cubit/search_cubit.dart'
    as _i36;
import 'package:paisa/features/settings/data/authenticate.dart' as _i3;
import 'package:paisa/features/settings/data/file_handler.dart' as _i65;
import 'package:paisa/features/settings/data/repository/csv_export_impl.dart'
    as _i63;
import 'package:paisa/features/settings/data/repository/json_export_import_impl.dart'
    as _i64;
import 'package:paisa/features/settings/data/repository/settings_repository_impl.dart'
    as _i39;
import 'package:paisa/features/settings/domain/repository/import_export.dart'
    as _i62;
import 'package:paisa/features/settings/domain/repository/settings_repository.dart'
    as _i38;
import 'package:paisa/features/settings/domain/use_case/csv_file_export_use_case.dart'
    as _i92;
import 'package:paisa/features/settings/domain/use_case/json_file_export_use_case.dart'
    as _i77;
import 'package:paisa/features/settings/domain/use_case/json_file_import_use_case.dart'
    as _i78;
import 'package:paisa/features/settings/domain/use_case/setting_use_case.dart'
    as _i42;
import 'package:paisa/features/settings/domain/use_case/settings_use_case.dart'
    as _i40;
import 'package:paisa/features/settings/presentation/cubit/settings_cubit.dart'
    as _i96;
import 'package:paisa/features/transaction/data/data_sources/local_transaction_data_manager.dart'
    as _i14;
import 'package:paisa/features/transaction/data/data_sources/local_transaction_data_manager_impl.dart'
    as _i15;
import 'package:paisa/features/transaction/data/model/expense_model.dart'
    as _i5;
import 'package:paisa/features/transaction/data/repository/expense_repository_impl.dart'
    as _i18;
import 'package:paisa/features/transaction/domain/repository/expense_repository.dart'
    as _i17;
import 'package:paisa/features/transaction/domain/use_case/add_expenses_use_case.dart'
    as _i47;
import 'package:paisa/features/transaction/domain/use_case/delete_expense_use_case.dart'
    as _i59;
import 'package:paisa/features/transaction/domain/use_case/delete_expenses_from_account_id.dart'
    as _i60;
import 'package:paisa/features/transaction/domain/use_case/delete_expenses_from_category_id.dart'
    as _i61;
import 'package:paisa/features/transaction/domain/use_case/expense_use_case.dart'
    as _i37;
import 'package:paisa/features/transaction/domain/use_case/filter_expense_use_case.dart'
    as _i19;
import 'package:paisa/features/transaction/domain/use_case/get_expense_from_account_id.dart'
    as _i22;
import 'package:paisa/features/transaction/domain/use_case/get_expense_from_category_id.dart'
    as _i23;
import 'package:paisa/features/transaction/domain/use_case/get_expense_use_case.dart'
    as _i21;
import 'package:paisa/features/transaction/domain/use_case/get_expenses_use_case.dart'
    as _i24;
import 'package:paisa/features/transaction/domain/use_case/update_expense_use_case.dart'
    as _i43;
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i84;

import 'module/hive_module.dart' as _i98;
import 'module/service_module.dart' as _i97;

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
  await gh.singletonAsync<_i4.Box<_i5.TransactionModel>>(
    () => hiveBoxModule.expenseBox,
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
  await gh.singletonAsync<_i4.Box<_i8.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i9.DebitModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i10.DebitTransactionsModel>>(
    () => hiveBoxModule.transactionsBox,
    preResolve: true,
  );
  gh.singleton<_i11.CountryRepository>(_i12.CountryRepositoryImpl());
  gh.singleton<_i13.DeviceInfoPlugin>(
      serviceBoxModule.providesDeviceInfoPlugin());
  gh.factory<_i14.ExpenseLocalDataManager>(() =>
      _i15.LocalExpenseDataManagerImpl(gh<_i16.Box<_i5.TransactionModel>>()));
  gh.singleton<_i17.ExpenseRepository>(_i18.ExpenseRepositoryImpl(
      dataSource: gh<_i14.ExpenseLocalDataManager>()));
  gh.singleton<_i19.FilterExpenseUseCase>(
      _i19.FilterExpenseUseCase(gh<_i17.ExpenseRepository>()));
  gh.factory<_i20.GetCountriesUseCase>(
      () => _i20.GetCountriesUseCase(repository: gh<_i11.CountryRepository>()));
  gh.singleton<_i21.GetExpenseUseCase>(
      _i21.GetExpenseUseCase(expenseRepository: gh<_i17.ExpenseRepository>()));
  gh.singleton<_i22.GetExpensesFromAccountIdUseCase>(
      _i22.GetExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i17.ExpenseRepository>()));
  gh.singleton<_i23.GetExpensesFromCategoryIdUseCase>(
      _i23.GetExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i17.ExpenseRepository>()));
  gh.singleton<_i24.GetExpensesUseCase>(
      _i24.GetExpensesUseCase(expenseRepository: gh<_i17.ExpenseRepository>()));
  gh.singleton<_i25.ImagePicker>(serviceBoxModule.providesImagePicker());
  gh.singleton<_i26.InAppReview>(serviceBoxModule.providesInAppReview());
  gh.singleton<_i27.LocalAccountDataManager>(_i27.LocalAccountDataManagerImpl(
      accountBox: gh<_i4.Box<_i6.AccountModel>>()));
  gh.singleton<_i28.LocalCategoryDataManager>(
      _i28.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i7.CategoryModel>>()));
  gh.singleton<_i29.LocalDebitDataSource>(_i29.LocalDebitDataSourceImpl(
    debtBox: gh<_i4.Box<_i9.DebitModel>>(),
    transactionsBox: gh<_i4.Box<_i10.DebitTransactionsModel>>(),
  ));
  gh.factory<_i30.LocalRecurringDataManager>(() =>
      _i31.LocalRecurringDataManagerImpl(gh<_i4.Box<_i8.RecurringModel>>()));
  gh.singleton<_i32.ProfileRepository>(_i33.ProfileRepositoryImpl(
    gh<_i25.ImagePicker>(),
    gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.singleton<_i34.RecurringRepository>(_i35.RecurringRepositoryImpl(
    gh<_i30.LocalRecurringDataManager>(),
    gh<_i14.ExpenseLocalDataManager>(),
  ));
  gh.factory<_i36.SearchCubit>(
      () => _i36.SearchCubit(gh<_i37.FilterExpenseUseCase>()));
  gh.factory<_i38.SettingsRepository>(() => _i39.SettingsRepositoryImpl(
      gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i40.SettingsUseCase>(
      _i40.SettingsUseCase(gh<_i38.SettingsRepository>()));
  gh.singleton<_i41.SummaryController>(
      _i41.SummaryController(gh<_i42.SettingsUseCase>()));
  gh.singleton<_i43.UpdateExpensesUseCase>(_i43.UpdateExpensesUseCase(
      expenseRepository: gh<_i17.ExpenseRepository>()));
  gh.singleton<_i44.AccountRepository>(_i45.AccountRepositoryImpl(
      dataSource: gh<_i27.LocalAccountDataManager>()));
  gh.singleton<_i46.AddAccountUseCase>(
      _i46.AddAccountUseCase(accountRepository: gh<_i44.AccountRepository>()));
  gh.singleton<_i47.AddExpenseUseCase>(
      _i47.AddExpenseUseCase(expenseRepository: gh<_i17.ExpenseRepository>()));
  gh.singleton<_i48.AddRecurringUseCase>(
      _i48.AddRecurringUseCase(gh<_i34.RecurringRepository>()));
  gh.singleton<_i49.CategoryRepository>(_i50.CategoryRepositoryImpl(
    dataSources: gh<_i28.LocalCategoryDataManager>(),
    expenseDataManager: gh<_i14.ExpenseLocalDataManager>(),
    settings: gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.factory<_i51.CountryPickerCubit>(() => _i51.CountryPickerCubit(
        gh<_i20.GetCountriesUseCase>(),
        gh<_i42.SettingsUseCase>(),
      ));
  gh.singleton<_i52.DebtRepository>(
      _i53.DebtRepositoryImpl(dataSource: gh<_i29.LocalDebitDataSource>()));
  gh.singleton<_i54.DeleteAccountUseCase>(_i54.DeleteAccountUseCase(
      accountRepository: gh<_i44.AccountRepository>()));
  gh.singleton<_i55.DeleteCategoryUseCase>(_i55.DeleteCategoryUseCase(
      categoryRepository: gh<_i49.CategoryRepository>()));
  gh.singleton<_i56.DeleteDebitTransactionUseCase>(
      _i56.DeleteDebitTransactionUseCase(
          debtRepository: gh<_i52.DebtRepository>()));
  gh.singleton<_i57.DeleteDebitTransactionsByDebitIdUseCase>(
      _i57.DeleteDebitTransactionsByDebitIdUseCase(
          debtRepository: gh<_i52.DebtRepository>()));
  gh.singleton<_i58.DeleteDebtUseCase>(
      _i58.DeleteDebtUseCase(debtRepository: gh<_i52.DebtRepository>()));
  gh.singleton<_i59.DeleteExpenseUseCase>(_i59.DeleteExpenseUseCase(
      expenseRepository: gh<_i17.ExpenseRepository>()));
  gh.singleton<_i60.DeleteExpensesFromAccountIdUseCase>(
      _i60.DeleteExpensesFromAccountIdUseCase(
          expenseRepository: gh<_i17.ExpenseRepository>()));
  gh.singleton<_i61.DeleteExpensesFromCategoryIdUseCase>(
      _i61.DeleteExpensesFromCategoryIdUseCase(
          expenseRepository: gh<_i17.ExpenseRepository>()));
  gh.lazySingleton<_i62.Export>(
    () => _i63.CSVExport(
      gh<_i13.DeviceInfoPlugin>(),
      gh<_i27.LocalAccountDataManager>(),
      gh<_i28.LocalCategoryDataManager>(),
      gh<_i14.ExpenseLocalDataManager>(),
    ),
    instanceName: 'csv',
  );
  gh.lazySingleton<_i62.Export>(
    () => _i64.JSONExportImpl(
      gh<_i27.LocalAccountDataManager>(),
      gh<_i28.LocalCategoryDataManager>(),
      gh<_i14.ExpenseLocalDataManager>(),
    ),
    instanceName: 'json_export',
  );
  gh.singleton<_i65.FileHandler>(_i65.FileHandler(
    gh<_i13.DeviceInfoPlugin>(),
    gh<_i27.LocalAccountDataManager>(),
    gh<_i28.LocalCategoryDataManager>(),
    gh<_i14.ExpenseLocalDataManager>(),
  ));
  gh.singleton<_i66.GetAccountUseCase>(
      _i66.GetAccountUseCase(accountRepository: gh<_i44.AccountRepository>()));
  gh.singleton<_i67.GetAccountsUseCase>(
      _i67.GetAccountsUseCase(accountRepository: gh<_i44.AccountRepository>()));
  gh.singleton<_i68.GetCategoryUseCase>(_i68.GetCategoryUseCase(
      categoryRepository: gh<_i49.CategoryRepository>()));
  gh.singleton<_i69.GetDebitTransactionsUseCase>(
      _i69.GetDebitTransactionsUseCase(
          debtRepository: gh<_i52.DebtRepository>()));
  gh.singleton<_i70.GetDebtUseCase>(
      _i70.GetDebtUseCase(debtRepository: gh<_i52.DebtRepository>()));
  gh.singleton<_i71.GetDefaultCategoriesUseCase>(
      _i71.GetDefaultCategoriesUseCase(
          categoryRepository: gh<_i49.CategoryRepository>()));
  gh.factory<_i72.HomeBloc>(() => _i72.HomeBloc(
        gh<_i37.GetExpensesUseCase>(),
        gh<_i73.GetDefaultCategoriesUseCase>(),
        gh<_i74.GetAccountUseCase>(),
        gh<_i73.GetCategoryUseCase>(),
        gh<_i37.GetExpensesFromCategoryIdUseCase>(),
      ));
  gh.singleton<_i75.ImagePickerUseCase>(
      _i75.ImagePickerUseCase(gh<_i32.ProfileRepository>()));
  gh.lazySingleton<_i62.Import>(
    () => _i64.JSONImportImpl(
      gh<_i13.DeviceInfoPlugin>(),
      gh<_i27.LocalAccountDataManager>(),
      gh<_i28.LocalCategoryDataManager>(),
      gh<_i14.ExpenseLocalDataManager>(),
    ),
    instanceName: 'json_import',
  );
  gh.singleton<_i76.InApp>(_i76.InApp(gh<_i26.InAppReview>()));
  gh.singleton<_i77.JSONFileExportUseCase>(_i77.JSONFileExportUseCase(
    gh<_i38.SettingsRepository>(),
    gh<_i62.Export>(instanceName: 'json_export'),
  ));
  gh.singleton<_i78.JSONFileImportUseCase>(_i78.JSONFileImportUseCase(
    gh<_i38.SettingsRepository>(),
    gh<_i62.Import>(instanceName: 'json_import'),
  ));
  gh.factory<_i79.OverviewCubit>(() => _i79.OverviewCubit(
        gh<_i37.GetExpensesUseCase>(),
        gh<_i73.GetCategoryUseCase>(),
        gh<_i73.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i80.ProfileCubit>(() => _i80.ProfileCubit(
        gh<_i81.ImagePickerUseCase>(),
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
      ));
  gh.factory<_i82.RecurringCubit>(
      () => _i82.RecurringCubit(gh<_i83.AddRecurringUseCase>()));
  gh.factory<_i84.TransactionBloc>(() => _i84.TransactionBloc(
        gh<_i40.SettingsUseCase>(),
        expenseUseCase: gh<_i37.GetExpenseUseCase>(),
        accountUseCase: gh<_i74.GetAccountUseCase>(),
        addExpenseUseCase: gh<_i37.AddExpenseUseCase>(),
        deleteExpenseUseCase: gh<_i37.DeleteExpenseUseCase>(),
        updateExpensesUseCase: gh<_i37.UpdateExpensesUseCase>(),
        accountsUseCase: gh<_i74.GetAccountsUseCase>(),
        defaultCategoriesUseCase: gh<_i73.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i85.UpdateAccountUseCase>(_i85.UpdateAccountUseCase(
      accountRepository: gh<_i44.AccountRepository>()));
  gh.singleton<_i86.UpdateCategoryUseCase>(_i86.UpdateCategoryUseCase(
      categoryRepository: gh<_i49.CategoryRepository>()));
  gh.singleton<_i87.UpdateDebtUseCase>(
      _i87.UpdateDebtUseCase(debtRepository: gh<_i52.DebtRepository>()));
  gh.factory<_i88.AccountsBloc>(() => _i88.AccountsBloc(
        getAccountUseCase: gh<_i74.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i74.DeleteAccountUseCase>(),
        getExpensesFromAccountIdUseCase:
            gh<_i37.GetExpensesFromAccountIdUseCase>(),
        addAccountUseCase: gh<_i74.AddAccountUseCase>(),
        getCategoryUseCase: gh<_i68.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i37.DeleteExpensesFromAccountIdUseCase>(),
        updateAccountUseCase: gh<_i74.UpdateAccountUseCase>(),
      ));
  gh.singleton<_i89.AddCategoryUseCase>(_i89.AddCategoryUseCase(
      categoryRepository: gh<_i49.CategoryRepository>()));
  gh.singleton<_i90.AddDebtUseCase>(
      _i90.AddDebtUseCase(debtRepository: gh<_i52.DebtRepository>()));
  gh.singleton<_i91.AddTransactionUseCase>(
      _i91.AddTransactionUseCase(debtRepository: gh<_i52.DebtRepository>()));
  gh.singleton<_i92.CSVFileExportUseCase>(_i92.CSVFileExportUseCase(
    gh<_i38.SettingsRepository>(),
    gh<_i62.Export>(instanceName: 'csv'),
  ));
  gh.factory<_i93.CategoryBloc>(() => _i93.CategoryBloc(
        getCategoryUseCase: gh<_i73.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i73.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i73.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i37.DeleteExpensesFromCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i73.UpdateCategoryUseCase>(),
      ));
  gh.factory<_i94.DebtsBloc>(() => _i94.DebtsBloc(
        addDebtUseCase: gh<_i95.AddDebtUseCase>(),
        getDebtUseCase: gh<_i95.GetDebtUseCase>(),
        getTransactionsUseCase: gh<_i95.GetDebitTransactionsUseCase>(),
        addTransactionUseCase: gh<_i95.AddTransactionUseCase>(),
        updateDebtUseCase: gh<_i95.UpdateDebtUseCase>(),
        deleteDebtUseCase: gh<_i95.DeleteDebtUseCase>(),
        deleteDebitTransactionUseCase: gh<_i95.DeleteDebitTransactionUseCase>(),
        deleteDebitTransactionsByDebitIdUseCase:
            gh<_i57.DeleteDebitTransactionsByDebitIdUseCase>(),
      ));
  gh.factory<_i96.SettingCubit>(() => _i96.SettingCubit(
        gh<_i37.GetExpensesUseCase>(),
        gh<_i73.GetDefaultCategoriesUseCase>(),
        gh<_i37.UpdateExpensesUseCase>(),
        gh<_i42.JSONFileImportUseCase>(),
        gh<_i42.JSONFileExportUseCase>(),
        gh<_i42.SettingsUseCase>(),
        gh<_i42.CSVFileExportUseCase>(),
      ));
  return getIt;
}

class _$ServiceBoxModule extends _i97.ServiceBoxModule {}

class _$HiveBoxModule extends _i98.HiveBoxModule {}
