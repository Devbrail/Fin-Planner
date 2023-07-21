// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i16;
import 'package:image_picker/image_picker.dart' as _i18;
import 'package:in_app_review/in_app_review.dart' as _i19;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/core/in_app.dart' as _i74;
import 'package:paisa/features/account/data/data_sources/local/account_data_manager.dart'
    as _i20;
import 'package:paisa/features/account/data/model/account_model.dart' as _i7;
import 'package:paisa/features/account/data/repository/account_repository_impl.dart'
    as _i38;
import 'package:paisa/features/account/domain/repository/account_repository.dart'
    as _i37;
import 'package:paisa/features/account/domain/use_case/account_use_case.dart'
    as _i72;
import 'package:paisa/features/account/domain/use_case/add_account_use_case.dart'
    as _i39;
import 'package:paisa/features/account/domain/use_case/delete_account_use_case.dart'
    as _i47;
import 'package:paisa/features/account/domain/use_case/get_account_use_case.dart'
    as _i59;
import 'package:paisa/features/account/domain/use_case/get_accounts_use_case.dart'
    as _i60;
import 'package:paisa/features/account/domain/use_case/update_account_use_case.dart'
    as _i84;
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart'
    as _i87;
import 'package:paisa/features/category/data/data_sources/local/category_data_source.dart'
    as _i21;
import 'package:paisa/features/category/data/model/category_model.dart' as _i10;
import 'package:paisa/features/category/data/repository/category_repository_impl.dart'
    as _i43;
import 'package:paisa/features/category/domain/repository/category_repository.dart'
    as _i42;
import 'package:paisa/features/category/domain/use_case/add_category_use_case.dart'
    as _i88;
import 'package:paisa/features/category/domain/use_case/category_use_case.dart'
    as _i71;
import 'package:paisa/features/category/domain/use_case/delete_category_use_case.dart'
    as _i48;
import 'package:paisa/features/category/domain/use_case/get_category_use_case.dart'
    as _i61;
import 'package:paisa/features/category/domain/use_case/get_default_categories_use_case.dart'
    as _i64;
import 'package:paisa/features/category/domain/use_case/update_category_use_case.dart'
    as _i85;
import 'package:paisa/features/category/presentation/bloc/category_bloc.dart'
    as _i92;
import 'package:paisa/features/country_picker/data/repository/country_repository_impl.dart'
    as _i12;
import 'package:paisa/features/country_picker/domain/repository/country_repository.dart'
    as _i11;
import 'package:paisa/features/country_picker/domain/use_case/get_contries_user_case.dart'
    as _i17;
import 'package:paisa/features/country_picker/presentation/cubit/country_picker_cubit.dart'
    as _i44;
import 'package:paisa/features/debit/data/data_sources/local/debit_local_data_source_impl.dart'
    as _i22;
import 'package:paisa/features/debit/data/models/debit_model.dart' as _i9;
import 'package:paisa/features/debit/data/models/debit_transactions_model.dart'
    as _i8;
import 'package:paisa/features/debit/data/repository/debit_repository_impl.dart'
    as _i46;
import 'package:paisa/features/debit/domain/repository/debit_repository.dart'
    as _i45;
import 'package:paisa/features/debit/domain/use_case/add_debit_transaction_use_case.dart'
    as _i89;
import 'package:paisa/features/debit/domain/use_case/add_debit_use.case.dart'
    as _i90;
import 'package:paisa/features/debit/domain/use_case/debit_use_case.dart'
    as _i94;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transaction_use_case.dart'
    as _i49;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transactions_by_debit_id_use_case.dart'
    as _i50;
import 'package:paisa/features/debit/domain/use_case/delete_debit_use_case.dart'
    as _i51;
import 'package:paisa/features/debit/domain/use_case/get_debit_transactions_use_case.dart'
    as _i62;
import 'package:paisa/features/debit/domain/use_case/get_debit_use_case.dart'
    as _i63;
import 'package:paisa/features/debit/domain/use_case/update_debit_use.case.dart'
    as _i86;
import 'package:paisa/features/debit/presentation/cubit/debts_bloc.dart'
    as _i93;
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart'
    as _i69;
import 'package:paisa/features/home/presentation/controller/summary_controller.dart'
    as _i32;
import 'package:paisa/features/home/presentation/cubit/overview/overview_cubit.dart'
    as _i77;
import 'package:paisa/features/profile/data/repository/profile_repository_impl.dart'
    as _i26;
import 'package:paisa/features/profile/domain/repository/profile_repository.dart'
    as _i25;
import 'package:paisa/features/profile/domain/use_case/image_picker_use_case.dart'
    as _i73;
import 'package:paisa/features/profile/domain/use_case/profile_use_case.dart'
    as _i79;
import 'package:paisa/features/profile/presentation/cubit/profile_cubit.dart'
    as _i78;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager.dart'
    as _i23;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager_impl.dart'
    as _i24;
import 'package:paisa/features/recurring/data/model/recurring.dart' as _i6;
import 'package:paisa/features/recurring/data/repository/recurring_repository_impl.dart'
    as _i28;
import 'package:paisa/features/recurring/domain/repository/recurring_repository.dart'
    as _i27;
import 'package:paisa/features/recurring/domain/use_case/add_recurring_use_case.dart'
    as _i40;
import 'package:paisa/features/recurring/domain/use_case/recurring_use_case.dart'
    as _i81;
import 'package:paisa/features/recurring/presentation/cubit/recurring_cubit.dart'
    as _i80;
import 'package:paisa/features/search/domain/use_case/filter_expense_use_case.dart'
    as _i82;
import 'package:paisa/features/search/presentation/cubit/search_cubit.dart'
    as _i95;
import 'package:paisa/features/settings/data/authenticate.dart' as _i3;
import 'package:paisa/features/settings/data/file_handler.dart' as _i58;
import 'package:paisa/features/settings/data/repository/csv_export_impl.dart'
    as _i56;
import 'package:paisa/features/settings/data/repository/json_export_import_impl.dart'
    as _i57;
import 'package:paisa/features/settings/data/repository/settings_repository_impl.dart'
    as _i30;
import 'package:paisa/features/settings/domain/repository/import_export.dart'
    as _i55;
import 'package:paisa/features/settings/domain/repository/settings_repository.dart'
    as _i29;
import 'package:paisa/features/settings/domain/use_case/csv_file_export_use_case.dart'
    as _i91;
import 'package:paisa/features/settings/domain/use_case/json_file_export_use_case.dart'
    as _i75;
import 'package:paisa/features/settings/domain/use_case/json_file_import_use_case.dart'
    as _i76;
import 'package:paisa/features/settings/domain/use_case/setting_use_case.dart'
    as _i33;
import 'package:paisa/features/settings/domain/use_case/settings_use_case.dart'
    as _i31;
import 'package:paisa/features/settings/presentation/cubit/settings_cubit.dart'
    as _i96;
import 'package:paisa/features/transaction/data/data_sources/local_transaction_data_manager.dart'
    as _i14;
import 'package:paisa/features/transaction/data/data_sources/local_transaction_data_manager_impl.dart'
    as _i15;
import 'package:paisa/features/transaction/data/model/expense_model.dart'
    as _i5;
import 'package:paisa/features/transaction/data/repository/expense_repository_impl.dart'
    as _i35;
import 'package:paisa/features/transaction/domain/repository/expense_repository.dart'
    as _i34;
import 'package:paisa/features/transaction/domain/use_case/add_transaction_use_case.dart'
    as _i41;
import 'package:paisa/features/transaction/domain/use_case/delete_transaction_from_category_id_use_case.dart'
    as _i54;
import 'package:paisa/features/transaction/domain/use_case/delete_transaction_use_case.dart'
    as _i52;
import 'package:paisa/features/transaction/domain/use_case/delete_transactions_by_account_id_use_case.dart'
    as _i53;
import 'package:paisa/features/transaction/domain/use_case/get_transaction_use_case.dart'
    as _i65;
import 'package:paisa/features/transaction/domain/use_case/get_transactions_by_account_id_use_case.dart'
    as _i66;
import 'package:paisa/features/transaction/domain/use_case/get_transactions_by_category_id_use_case.dart'
    as _i67;
import 'package:paisa/features/transaction/domain/use_case/get_transactions_use_case.dart'
    as _i68;
import 'package:paisa/features/transaction/domain/use_case/transaction_use_case.dart'
    as _i70;
import 'package:paisa/features/transaction/domain/use_case/update_expense_use_case.dart'
    as _i36;
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i83;

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
  await gh.singletonAsync<_i4.Box<_i6.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
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
  await gh.singletonAsync<_i4.Box<_i9.DebitModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i10.CategoryModel>>(
    () => hiveBoxModule.categoryBox,
    preResolve: true,
  );
  gh.singleton<_i11.CountryRepository>(_i12.CountryRepositoryImpl());
  gh.singleton<_i13.DeviceInfoPlugin>(
      serviceBoxModule.providesDeviceInfoPlugin());
  gh.factory<_i14.ExpenseLocalDataManager>(() =>
      _i15.LocalExpenseDataManagerImpl(gh<_i16.Box<_i5.TransactionModel>>()));
  gh.factory<_i17.GetCountriesUseCase>(
      () => _i17.GetCountriesUseCase(repository: gh<_i11.CountryRepository>()));
  gh.singleton<_i18.ImagePicker>(serviceBoxModule.providesImagePicker());
  gh.singleton<_i19.InAppReview>(serviceBoxModule.providesInAppReview());
  gh.singleton<_i20.LocalAccountDataManager>(_i20.LocalAccountDataManagerImpl(
      accountBox: gh<_i4.Box<_i7.AccountModel>>()));
  gh.singleton<_i21.LocalCategoryDataManager>(
      _i21.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i10.CategoryModel>>()));
  gh.singleton<_i22.LocalDebitDataSource>(_i22.LocalDebitDataSourceImpl(
    debtBox: gh<_i4.Box<_i9.DebitModel>>(),
    transactionsBox: gh<_i4.Box<_i8.DebitTransactionsModel>>(),
  ));
  gh.factory<_i23.LocalRecurringDataManager>(() =>
      _i24.LocalRecurringDataManagerImpl(gh<_i4.Box<_i6.RecurringModel>>()));
  gh.singleton<_i25.ProfileRepository>(_i26.ProfileRepositoryImpl(
    gh<_i18.ImagePicker>(),
    gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.singleton<_i27.RecurringRepository>(_i28.RecurringRepositoryImpl(
    gh<_i23.LocalRecurringDataManager>(),
    gh<_i14.ExpenseLocalDataManager>(),
  ));
  gh.factory<_i29.SettingsRepository>(() => _i30.SettingsRepositoryImpl(
      gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i31.SettingsUseCase>(
      _i31.SettingsUseCase(gh<_i29.SettingsRepository>()));
  gh.singleton<_i32.SummaryController>(
      _i32.SummaryController(gh<_i33.SettingsUseCase>()));
  gh.singleton<_i34.TransactionRepository>(_i35.ExpenseRepositoryImpl(
      dataSource: gh<_i14.ExpenseLocalDataManager>()));
  gh.singleton<_i36.UpdateTransactionUseCase>(_i36.UpdateTransactionUseCase(
      expenseRepository: gh<_i34.TransactionRepository>()));
  gh.singleton<_i37.AccountRepository>(_i38.AccountRepositoryImpl(
      dataSource: gh<_i20.LocalAccountDataManager>()));
  gh.singleton<_i39.AddAccountUseCase>(
      _i39.AddAccountUseCase(accountRepository: gh<_i37.AccountRepository>()));
  gh.singleton<_i40.AddRecurringUseCase>(
      _i40.AddRecurringUseCase(gh<_i27.RecurringRepository>()));
  gh.singleton<_i41.AddTransactionUseCase>(_i41.AddTransactionUseCase(
      expenseRepository: gh<_i34.TransactionRepository>()));
  gh.singleton<_i42.CategoryRepository>(_i43.CategoryRepositoryImpl(
    dataSources: gh<_i21.LocalCategoryDataManager>(),
    expenseDataManager: gh<_i14.ExpenseLocalDataManager>(),
  ));
  gh.factory<_i44.CountryPickerCubit>(() => _i44.CountryPickerCubit(
        gh<_i17.GetCountriesUseCase>(),
        gh<_i33.SettingsUseCase>(),
      ));
  gh.singleton<_i45.DebitRepository>(
      _i46.DebtRepositoryImpl(dataSource: gh<_i22.LocalDebitDataSource>()));
  gh.singleton<_i47.DeleteAccountUseCase>(_i47.DeleteAccountUseCase(
      accountRepository: gh<_i37.AccountRepository>()));
  gh.singleton<_i48.DeleteCategoryUseCase>(_i48.DeleteCategoryUseCase(
      categoryRepository: gh<_i42.CategoryRepository>()));
  gh.singleton<_i49.DeleteDebitTransactionUseCase>(
      _i49.DeleteDebitTransactionUseCase(
          debtRepository: gh<_i45.DebitRepository>()));
  gh.singleton<_i50.DeleteDebitTransactionsByDebitIdUseCase>(
      _i50.DeleteDebitTransactionsByDebitIdUseCase(
          debtRepository: gh<_i45.DebitRepository>()));
  gh.singleton<_i51.DeleteDebitUseCase>(
      _i51.DeleteDebitUseCase(debtRepository: gh<_i45.DebitRepository>()));
  gh.singleton<_i52.DeleteTransactionUseCase>(_i52.DeleteTransactionUseCase(
      expenseRepository: gh<_i34.TransactionRepository>()));
  gh.singleton<_i53.DeleteTransactionsByAccountIdUseCase>(
      _i53.DeleteTransactionsByAccountIdUseCase(
          expenseRepository: gh<_i34.TransactionRepository>()));
  gh.singleton<_i54.DeleteTransactionsByCategoryIdUseCase>(
      _i54.DeleteTransactionsByCategoryIdUseCase(
          transactionRepository: gh<_i34.TransactionRepository>()));
  gh.lazySingleton<_i55.Export>(
    () => _i56.CSVExport(
      gh<_i13.DeviceInfoPlugin>(),
      gh<_i20.LocalAccountDataManager>(),
      gh<_i21.LocalCategoryDataManager>(),
      gh<_i14.ExpenseLocalDataManager>(),
    ),
    instanceName: 'csv',
  );
  gh.lazySingleton<_i55.Export>(
    () => _i57.JSONExportImpl(
      gh<_i20.LocalAccountDataManager>(),
      gh<_i21.LocalCategoryDataManager>(),
      gh<_i14.ExpenseLocalDataManager>(),
    ),
    instanceName: 'json_export',
  );
  gh.singleton<_i58.FileHandler>(_i58.FileHandler(
    gh<_i13.DeviceInfoPlugin>(),
    gh<_i20.LocalAccountDataManager>(),
    gh<_i21.LocalCategoryDataManager>(),
    gh<_i14.ExpenseLocalDataManager>(),
  ));
  gh.singleton<_i59.GetAccountUseCase>(
      _i59.GetAccountUseCase(accountRepository: gh<_i37.AccountRepository>()));
  gh.singleton<_i60.GetAccountsUseCase>(
      _i60.GetAccountsUseCase(accountRepository: gh<_i37.AccountRepository>()));
  gh.singleton<_i61.GetCategoryUseCase>(_i61.GetCategoryUseCase(
      categoryRepository: gh<_i42.CategoryRepository>()));
  gh.singleton<_i62.GetDebitTransactionsUseCase>(
      _i62.GetDebitTransactionsUseCase(
          debtRepository: gh<_i45.DebitRepository>()));
  gh.singleton<_i63.GetDebitUseCase>(
      _i63.GetDebitUseCase(debtRepository: gh<_i45.DebitRepository>()));
  gh.singleton<_i64.GetDefaultCategoriesUseCase>(
      _i64.GetDefaultCategoriesUseCase(
          categoryRepository: gh<_i42.CategoryRepository>()));
  gh.singleton<_i65.GetTransactionUseCase>(_i65.GetTransactionUseCase(
      transactionRepository: gh<_i34.TransactionRepository>()));
  gh.singleton<_i66.GetTransactionsByAccountIdUseCase>(
      _i66.GetTransactionsByAccountIdUseCase(
          expenseRepository: gh<_i34.TransactionRepository>()));
  gh.singleton<_i67.GetTransactionsByCategoryIdUseCase>(
      _i67.GetTransactionsByCategoryIdUseCase(
          expenseRepository: gh<_i34.TransactionRepository>()));
  gh.singleton<_i68.GetTransactionsUseCase>(_i68.GetTransactionsUseCase(
      expenseRepository: gh<_i34.TransactionRepository>()));
  gh.factory<_i69.HomeBloc>(() => _i69.HomeBloc(
        gh<_i70.GetTransactionsUseCase>(),
        gh<_i71.GetDefaultCategoriesUseCase>(),
        gh<_i72.GetAccountUseCase>(),
        gh<_i71.GetCategoryUseCase>(),
        gh<_i70.GetTransactionsByCategoryIdUseCase>(),
      ));
  gh.singleton<_i73.ImagePickerUseCase>(
      _i73.ImagePickerUseCase(gh<_i25.ProfileRepository>()));
  gh.lazySingleton<_i55.Import>(
    () => _i57.JSONImportImpl(
      gh<_i13.DeviceInfoPlugin>(),
      gh<_i20.LocalAccountDataManager>(),
      gh<_i21.LocalCategoryDataManager>(),
      gh<_i14.ExpenseLocalDataManager>(),
    ),
    instanceName: 'json_import',
  );
  gh.singleton<_i74.InApp>(_i74.InApp(gh<_i19.InAppReview>()));
  gh.singleton<_i75.JSONFileExportUseCase>(_i75.JSONFileExportUseCase(
    gh<_i29.SettingsRepository>(),
    gh<_i55.Export>(instanceName: 'json_export'),
  ));
  gh.singleton<_i76.JSONFileImportUseCase>(_i76.JSONFileImportUseCase(
    gh<_i29.SettingsRepository>(),
    gh<_i55.Import>(instanceName: 'json_import'),
  ));
  gh.factory<_i77.OverviewCubit>(() => _i77.OverviewCubit(
        gh<_i70.GetTransactionsUseCase>(),
        gh<_i71.GetCategoryUseCase>(),
        gh<_i71.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i78.ProfileCubit>(() => _i78.ProfileCubit(
        gh<_i79.ImagePickerUseCase>(),
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
      ));
  gh.factory<_i80.RecurringCubit>(
      () => _i80.RecurringCubit(gh<_i81.AddRecurringUseCase>()));
  gh.singleton<_i82.SearchUseCase>(
      _i82.SearchUseCase(gh<_i34.TransactionRepository>()));
  gh.factory<_i83.TransactionBloc>(() => _i83.TransactionBloc(
        gh<_i31.SettingsUseCase>(),
        getTransactionUseCase: gh<_i70.GetTransactionUseCase>(),
        accountUseCase: gh<_i72.GetAccountUseCase>(),
        addTransactionUseCase: gh<_i70.AddTransactionUseCase>(),
        deleteTransactionUseCase: gh<_i70.DeleteTransactionUseCase>(),
        updateTransactionUseCase: gh<_i70.UpdateTransactionUseCase>(),
        accountsUseCase: gh<_i72.GetAccountsUseCase>(),
        getDefaultCategoriesUseCase: gh<_i71.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i84.UpdateAccountUseCase>(_i84.UpdateAccountUseCase(
      accountRepository: gh<_i37.AccountRepository>()));
  gh.singleton<_i85.UpdateCategoryUseCase>(_i85.UpdateCategoryUseCase(
      categoryRepository: gh<_i42.CategoryRepository>()));
  gh.singleton<_i86.UpdateDebitUseCase>(
      _i86.UpdateDebitUseCase(debtRepository: gh<_i45.DebitRepository>()));
  gh.factory<_i87.AccountsBloc>(() => _i87.AccountsBloc(
        getAccountUseCase: gh<_i72.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i72.DeleteAccountUseCase>(),
        getTransactionsByAccountIdUseCase:
            gh<_i70.GetTransactionsByAccountIdUseCase>(),
        addAccountUseCase: gh<_i72.AddAccountUseCase>(),
        getCategoryUseCase: gh<_i61.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i70.DeleteTransactionsByAccountIdUseCase>(),
        updateAccountUseCase: gh<_i72.UpdateAccountUseCase>(),
      ));
  gh.singleton<_i88.AddCategoryUseCase>(_i88.AddCategoryUseCase(
      categoryRepository: gh<_i42.CategoryRepository>()));
  gh.singleton<_i89.AddDebitTransactionUseCase>(_i89.AddDebitTransactionUseCase(
      debtRepository: gh<_i45.DebitRepository>()));
  gh.singleton<_i90.AddDebitUseCase>(
      _i90.AddDebitUseCase(debtRepository: gh<_i45.DebitRepository>()));
  gh.singleton<_i91.CSVFileExportUseCase>(_i91.CSVFileExportUseCase(
    gh<_i29.SettingsRepository>(),
    gh<_i55.Export>(instanceName: 'csv'),
  ));
  gh.factory<_i92.CategoryBloc>(() => _i92.CategoryBloc(
        getCategoryUseCase: gh<_i71.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i71.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i71.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i70.DeleteTransactionsByCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i71.UpdateCategoryUseCase>(),
      ));
  gh.factory<_i93.DebtsBloc>(() => _i93.DebtsBloc(
        addDebtUseCase: gh<_i94.AddDebitUseCase>(),
        getDebtUseCase: gh<_i94.GetDebitUseCase>(),
        getTransactionsUseCase: gh<_i94.GetDebitTransactionsUseCase>(),
        addTransactionUseCase: gh<_i94.AddDebitTransactionUseCase>(),
        updateDebtUseCase: gh<_i94.UpdateDebitUseCase>(),
        deleteDebtUseCase: gh<_i94.DeleteDebitUseCase>(),
        deleteDebitTransactionUseCase: gh<_i94.DeleteDebitTransactionUseCase>(),
        deleteDebitTransactionsByDebitIdUseCase:
            gh<_i50.DeleteDebitTransactionsByDebitIdUseCase>(),
      ));
  gh.factory<_i95.SearchCubit>(
      () => _i95.SearchCubit(gh<_i82.SearchUseCase>()));
  gh.factory<_i96.SettingCubit>(() => _i96.SettingCubit(
        gh<_i70.GetTransactionsUseCase>(),
        gh<_i71.GetDefaultCategoriesUseCase>(),
        gh<_i70.UpdateTransactionUseCase>(),
        gh<_i33.JSONFileImportUseCase>(),
        gh<_i33.JSONFileExportUseCase>(),
        gh<_i33.SettingsUseCase>(),
        gh<_i33.CSVFileExportUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i97.HiveBoxModule {}

class _$ServiceBoxModule extends _i98.ServiceBoxModule {}
