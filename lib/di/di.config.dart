// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i23;
import 'package:image_picker/image_picker.dart' as _i15;
import 'package:in_app_review/in_app_review.dart' as _i16;
import 'package:injectable/injectable.dart' as _i2;

import '../core/in_app.dart' as _i74;
import '../features/account/data/data_sources/local/account_data_manager.dart'
    as _i17;
import '../features/account/data/model/account_model.dart' as _i9;
import '../features/account/data/repository/account_repository_impl.dart'
    as _i38;
import '../features/account/domain/repository/account_repository.dart' as _i37;
import '../features/account/domain/use_case/account_use_case.dart' as _i72;
import '../features/account/domain/use_case/add_account_use_case.dart' as _i39;
import '../features/account/domain/use_case/delete_account_use_case.dart'
    as _i47;
import '../features/account/domain/use_case/get_account_use_case.dart' as _i59;
import '../features/account/domain/use_case/get_accounts_use_case.dart' as _i60;
import '../features/account/domain/use_case/update_account_use_case.dart'
    as _i84;
import '../features/account/presentation/bloc/accounts_bloc.dart' as _i87;
import '../features/category/data/data_sources/local/category_data_source.dart'
    as _i18;
import '../features/category/data/model/category_model.dart' as _i8;
import '../features/category/data/repository/category_repository_impl.dart'
    as _i43;
import '../features/category/domain/repository/category_repository.dart'
    as _i42;
import '../features/category/domain/use_case/add_category_use_case.dart'
    as _i88;
import '../features/category/domain/use_case/category_use_case.dart' as _i71;
import '../features/category/domain/use_case/delete_category_use_case.dart'
    as _i48;
import '../features/category/domain/use_case/get_category_use_case.dart'
    as _i61;
import '../features/category/domain/use_case/get_default_categories_use_case.dart'
    as _i64;
import '../features/category/domain/use_case/update_category_use_case.dart'
    as _i85;
import '../features/category/presentation/bloc/category_bloc.dart' as _i92;
import '../features/country_picker/data/repository/country_repository_impl.dart'
    as _i12;
import '../features/country_picker/domain/repository/country_repository.dart'
    as _i11;
import '../features/country_picker/domain/use_case/get_contries_user_case.dart'
    as _i14;
import '../features/country_picker/presentation/cubit/country_picker_cubit.dart'
    as _i44;
import '../features/debit/data/data_sources/local/debit_local_data_source_impl.dart'
    as _i19;
import '../features/debit/data/models/debit_model.dart' as _i7;
import '../features/debit/data/models/debit_transactions_model.dart' as _i6;
import '../features/debit/data/repository/debit_repository_impl.dart' as _i46;
import '../features/debit/domain/repository/debit_repository.dart' as _i45;
import '../features/debit/domain/use_case/add_debit_transaction_use_case.dart'
    as _i89;
import '../features/debit/domain/use_case/add_debit_use.case.dart' as _i90;
import '../features/debit/domain/use_case/debit_use_case.dart' as _i94;
import '../features/debit/domain/use_case/delete_debit_transaction_use_case.dart'
    as _i49;
import '../features/debit/domain/use_case/delete_debit_transactions_by_debit_id_use_case.dart'
    as _i50;
import '../features/debit/domain/use_case/delete_debit_use_case.dart' as _i51;
import '../features/debit/domain/use_case/get_debit_transactions_use_case.dart'
    as _i62;
import '../features/debit/domain/use_case/get_debit_use_case.dart' as _i63;
import '../features/debit/domain/use_case/update_debit_use.case.dart' as _i86;
import '../features/debit/presentation/cubit/debts_bloc.dart' as _i93;
import '../features/home/presentation/bloc/home/home_bloc.dart' as _i69;
import '../features/home/presentation/controller/summary_controller.dart'
    as _i31;
import '../features/home/presentation/cubit/overview/overview_cubit.dart'
    as _i77;
import '../features/home/presentation/cubit/summary/cubit/summary_cubit.dart'
    as _i33;
import '../features/profile/data/repository/profile_repository_impl.dart'
    as _i25;
import '../features/profile/domain/repository/profile_repository.dart' as _i24;
import '../features/profile/domain/use_case/image_picker_use_case.dart' as _i73;
import '../features/profile/domain/use_case/profile_use_case.dart' as _i79;
import '../features/profile/presentation/cubit/profile_cubit.dart' as _i78;
import '../features/recurring/data/data_sources/local_recurring_data_manager.dart'
    as _i20;
import '../features/recurring/data/data_sources/local_recurring_data_manager_impl.dart'
    as _i21;
import '../features/recurring/data/model/recurring.dart' as _i10;
import '../features/recurring/data/repository/recurring_repository_impl.dart'
    as _i27;
import '../features/recurring/domain/repository/recurring_repository.dart'
    as _i26;
import '../features/recurring/domain/use_case/add_recurring_use_case.dart'
    as _i40;
import '../features/recurring/domain/use_case/recurring_use_case.dart' as _i81;
import '../features/recurring/presentation/cubit/recurring_cubit.dart' as _i80;
import '../features/search/domain/use_case/filter_expense_use_case.dart'
    as _i82;
import '../features/search/presentation/cubit/search_cubit.dart' as _i95;
import '../features/settings/data/authenticate.dart' as _i3;
import '../features/settings/data/file_handler.dart' as _i58;
import '../features/settings/data/repository/csv_export_impl.dart' as _i56;
import '../features/settings/data/repository/json_export_import_impl.dart'
    as _i57;
import '../features/settings/data/repository/settings_repository_impl.dart'
    as _i29;
import '../features/settings/domain/repository/import_export.dart' as _i55;
import '../features/settings/domain/repository/settings_repository.dart'
    as _i28;
import '../features/settings/domain/use_case/csv_file_export_use_case.dart'
    as _i91;
import '../features/settings/domain/use_case/json_file_export_use_case.dart'
    as _i75;
import '../features/settings/domain/use_case/json_file_import_use_case.dart'
    as _i76;
import '../features/settings/domain/use_case/setting_use_case.dart' as _i32;
import '../features/settings/domain/use_case/settings_use_case.dart' as _i30;
import '../features/settings/presentation/cubit/settings_cubit.dart' as _i96;
import '../features/transaction/data/data_sources/local/transaction_data_manager.dart'
    as _i22;
import '../features/transaction/data/model/transaction_model.dart' as _i5;
import '../features/transaction/data/repository/transaction_repository_impl.dart'
    as _i35;
import '../features/transaction/domain/repository/transaction_repository.dart'
    as _i34;
import '../features/transaction/domain/use_case/add_transaction_use_case.dart'
    as _i41;
import '../features/transaction/domain/use_case/delete_transaction_from_category_id_use_case.dart'
    as _i54;
import '../features/transaction/domain/use_case/delete_transaction_use_case.dart'
    as _i52;
import '../features/transaction/domain/use_case/delete_transactions_by_account_id_use_case.dart'
    as _i53;
import '../features/transaction/domain/use_case/get_transaction_use_case.dart'
    as _i65;
import '../features/transaction/domain/use_case/get_transactions_by_account_id_use_case.dart'
    as _i66;
import '../features/transaction/domain/use_case/get_transactions_by_category_id_use_case.dart'
    as _i67;
import '../features/transaction/domain/use_case/get_transactions_use_case.dart'
    as _i68;
import '../features/transaction/domain/use_case/transaction_use_case.dart'
    as _i70;
import '../features/transaction/domain/use_case/update_expense_use_case.dart'
    as _i36;
import '../features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i83;
import 'module/hive_module.dart' as _i97;
import 'module/service_module.dart' as _i98;

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
  await gh.singletonAsync<_i4.Box<_i5.TransactionModel>>(
    () => hiveBoxModule.expenseBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i6.DebitTransactionsModel>>(
    () => hiveBoxModule.transactionsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i7.DebitModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i8.CategoryModel>>(
    () => hiveBoxModule.categoryBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i9.AccountModel>>(
    () => hiveBoxModule.accountBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<dynamic>>(
    () => hiveBoxModule.boxDynamic,
    instanceName: 'settings',
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i10.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
    preResolve: true,
  );
  gh.singleton<_i11.CountryRepository>(_i12.CountryRepositoryImpl());
  gh.singleton<_i13.DeviceInfoPlugin>(
      serviceBoxModule.providesDeviceInfoPlugin());
  gh.factory<_i14.GetCountriesUseCase>(
      () => _i14.GetCountriesUseCase(repository: gh<_i11.CountryRepository>()));
  gh.singleton<_i15.ImagePicker>(serviceBoxModule.providesImagePicker());
  gh.singleton<_i16.InAppReview>(serviceBoxModule.providesInAppReview());
  gh.singleton<_i17.LocalAccountManager>(_i17.LocalAccountManagerImpl(
      accountBox: gh<_i4.Box<_i9.AccountModel>>()));
  gh.singleton<_i18.LocalCategoryManager>(
      _i18.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i8.CategoryModel>>()));
  gh.singleton<_i19.LocalDebitDataSource>(_i19.LocalDebitDataSourceImpl(
    debtBox: gh<_i4.Box<_i7.DebitModel>>(),
    transactionsBox: gh<_i4.Box<_i6.DebitTransactionsModel>>(),
  ));
  gh.factory<_i20.LocalRecurringDataManager>(() =>
      _i21.LocalRecurringDataManagerImpl(gh<_i4.Box<_i10.RecurringModel>>()));
  gh.factory<_i22.LocalTransactionManager>(() =>
      _i22.LocalTransactionManagerImpl(gh<_i23.Box<_i5.TransactionModel>>()));
  gh.singleton<_i24.ProfileRepository>(_i25.ProfileRepositoryImpl(
    gh<_i15.ImagePicker>(),
    gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.singleton<_i26.RecurringRepository>(_i27.RecurringRepositoryImpl(
    gh<_i20.LocalRecurringDataManager>(),
    gh<_i22.LocalTransactionManager>(),
  ));
  gh.factory<_i28.SettingsRepository>(() => _i29.SettingsRepositoryImpl(
      gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i30.SettingsUseCase>(
      _i30.SettingsUseCase(gh<_i28.SettingsRepository>()));
  gh.singleton<_i31.SummaryController>(
      _i31.SummaryController(gh<_i32.SettingsUseCase>()));
  gh.factory<_i33.SummaryCubit>(() => _i33.SummaryCubit());
  gh.singleton<_i34.TransactionRepository>(_i35.ExpenseRepositoryImpl(
      dataSource: gh<_i22.LocalTransactionManager>()));
  gh.singleton<_i36.UpdateTransactionUseCase>(_i36.UpdateTransactionUseCase(
      expenseRepository: gh<_i34.TransactionRepository>()));
  gh.singleton<_i37.AccountRepository>(
      _i38.AccountRepositoryImpl(dataSource: gh<_i17.LocalAccountManager>()));
  gh.singleton<_i39.AddAccountUseCase>(
      _i39.AddAccountUseCase(accountRepository: gh<_i37.AccountRepository>()));
  gh.singleton<_i40.AddRecurringUseCase>(
      _i40.AddRecurringUseCase(gh<_i26.RecurringRepository>()));
  gh.singleton<_i41.AddTransactionUseCase>(_i41.AddTransactionUseCase(
      expenseRepository: gh<_i34.TransactionRepository>()));
  gh.singleton<_i42.CategoryRepository>(_i43.CategoryRepositoryImpl(
    dataSources: gh<_i18.LocalCategoryManager>(),
    expenseDataManager: gh<_i22.LocalTransactionManager>(),
  ));
  gh.factory<_i44.CountryPickerCubit>(() => _i44.CountryPickerCubit(
        gh<_i14.GetCountriesUseCase>(),
        gh<_i32.SettingsUseCase>(),
      ));
  gh.singleton<_i45.DebitRepository>(
      _i46.DebtRepositoryImpl(dataSource: gh<_i19.LocalDebitDataSource>()));
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
      gh<_i17.LocalAccountManager>(),
      gh<_i18.LocalCategoryManager>(),
      gh<_i22.LocalTransactionManager>(),
    ),
    instanceName: 'csv',
  );
  gh.lazySingleton<_i55.Export>(
    () => _i57.JSONExportImpl(
      gh<_i17.LocalAccountManager>(),
      gh<_i18.LocalCategoryManager>(),
      gh<_i22.LocalTransactionManager>(),
    ),
    instanceName: 'json_export',
  );
  gh.singleton<_i58.FileHandler>(_i58.FileHandler(
    gh<_i13.DeviceInfoPlugin>(),
    gh<_i17.LocalAccountManager>(),
    gh<_i18.LocalCategoryManager>(),
    gh<_i22.LocalTransactionManager>(),
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
      _i73.ImagePickerUseCase(gh<_i24.ProfileRepository>()));
  gh.lazySingleton<_i55.Import>(
    () => _i57.JSONImportImpl(
      gh<_i13.DeviceInfoPlugin>(),
      gh<_i17.LocalAccountManager>(),
      gh<_i18.LocalCategoryManager>(),
      gh<_i22.LocalTransactionManager>(),
    ),
    instanceName: 'json_import',
  );
  gh.singleton<_i74.InApp>(_i74.InApp(gh<_i16.InAppReview>()));
  gh.singleton<_i75.JSONFileExportUseCase>(_i75.JSONFileExportUseCase(
    gh<_i28.SettingsRepository>(),
    gh<_i55.Export>(instanceName: 'json_export'),
  ));
  gh.singleton<_i76.JSONFileImportUseCase>(_i76.JSONFileImportUseCase(
    gh<_i28.SettingsRepository>(),
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
        gh<_i30.SettingsUseCase>(),
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
  gh.factory<_i87.AccountBloc>(() => _i87.AccountBloc(
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
    gh<_i28.SettingsRepository>(),
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
  gh.factory<_i93.DebitBloc>(() => _i93.DebitBloc(
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
        gh<_i32.JSONFileImportUseCase>(),
        gh<_i32.JSONFileExportUseCase>(),
        gh<_i32.SettingsUseCase>(),
        gh<_i32.CSVFileExportUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i97.HiveBoxModule {}

class _$ServiceBoxModule extends _i98.ServiceBoxModule {}
