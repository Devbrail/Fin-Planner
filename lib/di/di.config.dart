// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i23;
import 'package:image_picker/image_picker.dart' as _i15;
import 'package:in_app_review/in_app_review.dart' as _i16;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/core/in_app.dart' as _i74;
import 'package:paisa/features/account/data/data_sources/local/account_data_manager.dart'
    as _i17;
import 'package:paisa/features/account/data/model/account_model.dart' as _i6;
import 'package:paisa/features/account/data/repository/account_repository_impl.dart'
    as _i37;
import 'package:paisa/features/account/domain/repository/account_repository.dart'
    as _i36;
import 'package:paisa/features/account/domain/use_case/account_use_case.dart'
    as _i71;
import 'package:paisa/features/account/domain/use_case/add_account_use_case.dart'
    as _i38;
import 'package:paisa/features/account/domain/use_case/delete_account_use_case.dart'
    as _i46;
import 'package:paisa/features/account/domain/use_case/get_account_use_case.dart'
    as _i58;
import 'package:paisa/features/account/domain/use_case/get_accounts_use_case.dart'
    as _i59;
import 'package:paisa/features/account/domain/use_case/update_account_use_case.dart'
    as _i84;
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart'
    as _i87;
import 'package:paisa/features/category/data/data_sources/local/category_data_source.dart'
    as _i18;
import 'package:paisa/features/category/data/model/category_model.dart' as _i7;
import 'package:paisa/features/category/data/repository/category_repository_impl.dart'
    as _i42;
import 'package:paisa/features/category/domain/repository/category_repository.dart'
    as _i41;
import 'package:paisa/features/category/domain/use_case/add_category_use_case.dart'
    as _i88;
import 'package:paisa/features/category/domain/use_case/category_use_case.dart'
    as _i72;
import 'package:paisa/features/category/domain/use_case/delete_category_use_case.dart'
    as _i47;
import 'package:paisa/features/category/domain/use_case/get_categories_use_case.dart'
    as _i60;
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
    as _i14;
import 'package:paisa/features/country_picker/presentation/cubit/country_picker_cubit.dart'
    as _i43;
import 'package:paisa/features/debit/data/data_sources/local/debit_local_data_source_impl.dart'
    as _i19;
import 'package:paisa/features/debit/data/models/debit_model.dart' as _i8;
import 'package:paisa/features/debit/data/models/debit_transactions_model.dart'
    as _i9;
import 'package:paisa/features/debit/data/repository/debit_repository_impl.dart'
    as _i45;
import 'package:paisa/features/debit/domain/repository/debit_repository.dart'
    as _i44;
import 'package:paisa/features/debit/domain/use_case/add_debit_transaction_use_case.dart'
    as _i89;
import 'package:paisa/features/debit/domain/use_case/add_debit_use.case.dart'
    as _i90;
import 'package:paisa/features/debit/domain/use_case/debit_use_case.dart'
    as _i95;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transaction_use_case.dart'
    as _i48;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transactions_by_debit_id_use_case.dart'
    as _i49;
import 'package:paisa/features/debit/domain/use_case/delete_debit_use_case.dart'
    as _i50;
import 'package:paisa/features/debit/domain/use_case/get_debit_transactions_use_case.dart'
    as _i62;
import 'package:paisa/features/debit/domain/use_case/get_debit_use_case.dart'
    as _i63;
import 'package:paisa/features/debit/domain/use_case/update_debit_use.case.dart'
    as _i86;
import 'package:paisa/features/debit/presentation/cubit/debts_bloc.dart'
    as _i94;
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart'
    as _i69;
import 'package:paisa/features/home/presentation/controller/summary_controller.dart'
    as _i31;
import 'package:paisa/features/home/presentation/cubit/combined_transaction/combined_transaction_cubit.dart'
    as _i93;
import 'package:paisa/features/home/presentation/cubit/overview/overview_cubit.dart'
    as _i77;
import 'package:paisa/features/profile/data/repository/profile_repository_impl.dart'
    as _i25;
import 'package:paisa/features/profile/domain/repository/profile_repository.dart'
    as _i24;
import 'package:paisa/features/profile/domain/use_case/image_picker_use_case.dart'
    as _i73;
import 'package:paisa/features/profile/domain/use_case/profile_use_case.dart'
    as _i79;
import 'package:paisa/features/profile/presentation/cubit/profile_cubit.dart'
    as _i78;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager.dart'
    as _i20;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager_impl.dart'
    as _i21;
import 'package:paisa/features/recurring/data/model/recurring.dart' as _i10;
import 'package:paisa/features/recurring/data/repository/recurring_repository_impl.dart'
    as _i27;
import 'package:paisa/features/recurring/domain/repository/recurring_repository.dart'
    as _i26;
import 'package:paisa/features/recurring/domain/use_case/add_recurring_use_case.dart'
    as _i39;
import 'package:paisa/features/recurring/domain/use_case/recurring_use_case.dart'
    as _i81;
import 'package:paisa/features/recurring/presentation/cubit/recurring_cubit.dart'
    as _i80;
import 'package:paisa/features/search/domain/use_case/filter_expense_use_case.dart'
    as _i82;
import 'package:paisa/features/search/presentation/cubit/search_cubit.dart'
    as _i96;
import 'package:paisa/features/settings/data/authenticate.dart' as _i3;
import 'package:paisa/features/settings/data/file_handler.dart' as _i57;
import 'package:paisa/features/settings/data/repository/csv_export_impl.dart'
    as _i56;
import 'package:paisa/features/settings/data/repository/json_export_import_impl.dart'
    as _i55;
import 'package:paisa/features/settings/data/repository/settings_repository_impl.dart'
    as _i29;
import 'package:paisa/features/settings/domain/repository/import_export.dart'
    as _i54;
import 'package:paisa/features/settings/domain/repository/settings_repository.dart'
    as _i28;
import 'package:paisa/features/settings/domain/use_case/csv_file_export_use_case.dart'
    as _i91;
import 'package:paisa/features/settings/domain/use_case/json_file_export_use_case.dart'
    as _i75;
import 'package:paisa/features/settings/domain/use_case/json_file_import_use_case.dart'
    as _i76;
import 'package:paisa/features/settings/domain/use_case/setting_use_case.dart'
    as _i32;
import 'package:paisa/features/settings/domain/use_case/settings_use_case.dart'
    as _i30;
import 'package:paisa/features/settings/presentation/cubit/settings_cubit.dart'
    as _i97;
import 'package:paisa/features/transaction/data/data_sources/local/transaction_data_manager.dart'
    as _i22;
import 'package:paisa/features/transaction/data/model/transaction_model.dart'
    as _i5;
import 'package:paisa/features/transaction/data/repository/transaction_repository_impl.dart'
    as _i34;
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart'
    as _i33;
import 'package:paisa/features/transaction/domain/use_case/add_transaction_use_case.dart'
    as _i40;
import 'package:paisa/features/transaction/domain/use_case/delete_transaction_from_category_id_use_case.dart'
    as _i53;
import 'package:paisa/features/transaction/domain/use_case/delete_transaction_use_case.dart'
    as _i51;
import 'package:paisa/features/transaction/domain/use_case/delete_transactions_by_account_id_use_case.dart'
    as _i52;
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
    as _i35;
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i83;

import 'module/hive_module.dart' as _i98;
import 'module/service_module.dart' as _i99;

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
  await gh.singletonAsync<_i4.Box<_i8.DebitModel>>(
    () => hiveBoxModule.debtsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i9.DebitTransactionsModel>>(
    () => hiveBoxModule.transactionsBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<_i10.RecurringModel>>(
    () => hiveBoxModule.recurringBox,
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<dynamic>>(
    () => hiveBoxModule.boxDynamic,
    instanceName: 'settings',
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
      accountBox: gh<_i4.Box<_i6.AccountModel>>()));
  gh.singleton<_i18.LocalCategoryManager>(
      _i18.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i7.CategoryModel>>()));
  gh.singleton<_i19.LocalDebitDataSource>(_i19.LocalDebitDataSourceImpl(
    debtBox: gh<_i4.Box<_i8.DebitModel>>(),
    transactionsBox: gh<_i4.Box<_i9.DebitTransactionsModel>>(),
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
  gh.singleton<_i33.TransactionRepository>(_i34.ExpenseRepositoryImpl(
      dataSource: gh<_i22.LocalTransactionManager>()));
  gh.singleton<_i35.UpdateTransactionUseCase>(_i35.UpdateTransactionUseCase(
      expenseRepository: gh<_i33.TransactionRepository>()));
  gh.singleton<_i36.AccountRepository>(
      _i37.AccountRepositoryImpl(dataSource: gh<_i17.LocalAccountManager>()));
  gh.singleton<_i38.AddAccountUseCase>(
      _i38.AddAccountUseCase(accountRepository: gh<_i36.AccountRepository>()));
  gh.singleton<_i39.AddRecurringUseCase>(
      _i39.AddRecurringUseCase(gh<_i26.RecurringRepository>()));
  gh.singleton<_i40.AddTransactionUseCase>(_i40.AddTransactionUseCase(
      expenseRepository: gh<_i33.TransactionRepository>()));
  gh.singleton<_i41.CategoryRepository>(_i42.CategoryRepositoryImpl(
    dataSources: gh<_i18.LocalCategoryManager>(),
    expenseDataManager: gh<_i22.LocalTransactionManager>(),
  ));
  gh.factory<_i43.CountryPickerCubit>(() => _i43.CountryPickerCubit(
        gh<_i14.GetCountriesUseCase>(),
        gh<_i32.SettingsUseCase>(),
      ));
  gh.singleton<_i44.DebitRepository>(
      _i45.DebtRepositoryImpl(dataSource: gh<_i19.LocalDebitDataSource>()));
  gh.singleton<_i46.DeleteAccountUseCase>(_i46.DeleteAccountUseCase(
      accountRepository: gh<_i36.AccountRepository>()));
  gh.singleton<_i47.DeleteCategoryUseCase>(_i47.DeleteCategoryUseCase(
      categoryRepository: gh<_i41.CategoryRepository>()));
  gh.singleton<_i48.DeleteDebitTransactionUseCase>(
      _i48.DeleteDebitTransactionUseCase(
          debtRepository: gh<_i44.DebitRepository>()));
  gh.singleton<_i49.DeleteDebitTransactionsByDebitIdUseCase>(
      _i49.DeleteDebitTransactionsByDebitIdUseCase(
          debtRepository: gh<_i44.DebitRepository>()));
  gh.singleton<_i50.DeleteDebitUseCase>(
      _i50.DeleteDebitUseCase(debtRepository: gh<_i44.DebitRepository>()));
  gh.singleton<_i51.DeleteTransactionUseCase>(_i51.DeleteTransactionUseCase(
      expenseRepository: gh<_i33.TransactionRepository>()));
  gh.singleton<_i52.DeleteTransactionsByAccountIdUseCase>(
      _i52.DeleteTransactionsByAccountIdUseCase(
          expenseRepository: gh<_i33.TransactionRepository>()));
  gh.singleton<_i53.DeleteTransactionsByCategoryIdUseCase>(
      _i53.DeleteTransactionsByCategoryIdUseCase(
          transactionRepository: gh<_i33.TransactionRepository>()));
  gh.lazySingleton<_i54.Export>(
    () => _i55.JSONExportImpl(
      gh<_i17.LocalAccountManager>(),
      gh<_i18.LocalCategoryManager>(),
      gh<_i22.LocalTransactionManager>(),
    ),
    instanceName: 'json_export',
  );
  gh.lazySingleton<_i54.Export>(
    () => _i56.CSVExport(
      gh<_i13.DeviceInfoPlugin>(),
      gh<_i17.LocalAccountManager>(),
      gh<_i18.LocalCategoryManager>(),
      gh<_i22.LocalTransactionManager>(),
    ),
    instanceName: 'csv',
  );
  gh.singleton<_i57.FileHandler>(_i57.FileHandler(
    gh<_i13.DeviceInfoPlugin>(),
    gh<_i17.LocalAccountManager>(),
    gh<_i18.LocalCategoryManager>(),
    gh<_i22.LocalTransactionManager>(),
  ));
  gh.singleton<_i58.GetAccountUseCase>(
      _i58.GetAccountUseCase(accountRepository: gh<_i36.AccountRepository>()));
  gh.singleton<_i59.GetAccountsUseCase>(
      _i59.GetAccountsUseCase(accountRepository: gh<_i36.AccountRepository>()));
  gh.singleton<_i60.GetCategoriesUseCase>(_i60.GetCategoriesUseCase(
      categoryRepository: gh<_i41.CategoryRepository>()));
  gh.singleton<_i61.GetCategoryUseCase>(_i61.GetCategoryUseCase(
      categoryRepository: gh<_i41.CategoryRepository>()));
  gh.singleton<_i62.GetDebitTransactionsUseCase>(
      _i62.GetDebitTransactionsUseCase(
          debtRepository: gh<_i44.DebitRepository>()));
  gh.singleton<_i63.GetDebitUseCase>(
      _i63.GetDebitUseCase(debtRepository: gh<_i44.DebitRepository>()));
  gh.singleton<_i64.GetDefaultCategoriesUseCase>(
      _i64.GetDefaultCategoriesUseCase(
          categoryRepository: gh<_i41.CategoryRepository>()));
  gh.singleton<_i65.GetTransactionUseCase>(_i65.GetTransactionUseCase(
      transactionRepository: gh<_i33.TransactionRepository>()));
  gh.singleton<_i66.GetTransactionsByAccountIdUseCase>(
      _i66.GetTransactionsByAccountIdUseCase(
          expenseRepository: gh<_i33.TransactionRepository>()));
  gh.singleton<_i67.GetTransactionsByCategoryIdUseCase>(
      _i67.GetTransactionsByCategoryIdUseCase(
          expenseRepository: gh<_i33.TransactionRepository>()));
  gh.singleton<_i68.GetTransactionsUseCase>(_i68.GetTransactionsUseCase(
      expenseRepository: gh<_i33.TransactionRepository>()));
  gh.factory<_i69.HomeBloc>(() => _i69.HomeBloc(
        gh<_i70.GetTransactionsUseCase>(),
        gh<_i71.GetAccountUseCase>(),
        gh<_i72.GetCategoryUseCase>(),
        gh<_i70.GetTransactionsByCategoryIdUseCase>(),
      ));
  gh.singleton<_i73.ImagePickerUseCase>(
      _i73.ImagePickerUseCase(gh<_i24.ProfileRepository>()));
  gh.lazySingleton<_i54.Import>(
    () => _i55.JSONImportImpl(
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
    gh<_i54.Export>(instanceName: 'json_export'),
  ));
  gh.singleton<_i76.JSONFileImportUseCase>(_i76.JSONFileImportUseCase(
    gh<_i28.SettingsRepository>(),
    gh<_i54.Import>(instanceName: 'json_import'),
  ));
  gh.factory<_i77.OverviewCubit>(() => _i77.OverviewCubit(
        gh<_i70.GetTransactionsUseCase>(),
        gh<_i72.GetCategoryUseCase>(),
        gh<_i72.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i78.ProfileCubit>(() => _i78.ProfileCubit(
        gh<_i79.ImagePickerUseCase>(),
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
      ));
  gh.factory<_i80.RecurringCubit>(
      () => _i80.RecurringCubit(gh<_i81.AddRecurringUseCase>()));
  gh.singleton<_i82.SearchUseCase>(
      _i82.SearchUseCase(gh<_i33.TransactionRepository>()));
  gh.factory<_i83.TransactionBloc>(() => _i83.TransactionBloc(
        gh<_i30.SettingsUseCase>(),
        getTransactionUseCase: gh<_i70.GetTransactionUseCase>(),
        accountUseCase: gh<_i71.GetAccountUseCase>(),
        addTransactionUseCase: gh<_i70.AddTransactionUseCase>(),
        deleteTransactionUseCase: gh<_i70.DeleteTransactionUseCase>(),
        updateTransactionUseCase: gh<_i70.UpdateTransactionUseCase>(),
        accountsUseCase: gh<_i71.GetAccountsUseCase>(),
        getDefaultCategoriesUseCase: gh<_i72.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i84.UpdateAccountUseCase>(_i84.UpdateAccountUseCase(
      accountRepository: gh<_i36.AccountRepository>()));
  gh.singleton<_i85.UpdateCategoryUseCase>(_i85.UpdateCategoryUseCase(
      categoryRepository: gh<_i41.CategoryRepository>()));
  gh.singleton<_i86.UpdateDebitUseCase>(
      _i86.UpdateDebitUseCase(debtRepository: gh<_i44.DebitRepository>()));
  gh.factory<_i87.AccountBloc>(() => _i87.AccountBloc(
        gh<_i60.GetCategoriesUseCase>(),
        gh<_i71.GetAccountUseCase>(),
        gh<_i71.DeleteAccountUseCase>(),
        gh<_i70.GetTransactionsByAccountIdUseCase>(),
        gh<_i71.AddAccountUseCase>(),
        gh<_i61.GetCategoryUseCase>(),
        gh<_i70.DeleteTransactionsByAccountIdUseCase>(),
        gh<_i71.UpdateAccountUseCase>(),
      ));
  gh.singleton<_i88.AddCategoryUseCase>(_i88.AddCategoryUseCase(
      categoryRepository: gh<_i41.CategoryRepository>()));
  gh.singleton<_i89.AddDebitTransactionUseCase>(_i89.AddDebitTransactionUseCase(
      debtRepository: gh<_i44.DebitRepository>()));
  gh.singleton<_i90.AddDebitUseCase>(
      _i90.AddDebitUseCase(debtRepository: gh<_i44.DebitRepository>()));
  gh.singleton<_i91.CSVFileExportUseCase>(_i91.CSVFileExportUseCase(
    gh<_i28.SettingsRepository>(),
    gh<_i54.Export>(instanceName: 'csv'),
  ));
  gh.factory<_i92.CategoryBloc>(() => _i92.CategoryBloc(
        getCategoryUseCase: gh<_i72.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i72.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i72.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i70.DeleteTransactionsByCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i72.UpdateCategoryUseCase>(),
      ));
  gh.factory<_i93.CombinedTransactionCubit>(() => _i93.CombinedTransactionCubit(
        gh<_i70.GetTransactionsUseCase>(),
        gh<_i71.GetAccountsUseCase>(),
        gh<_i72.GetCategoriesUseCase>(),
        gh<_i70.GetTransactionsByCategoryIdUseCase>(),
        gh<_i72.GetCategoryUseCase>(),
      ));
  gh.factory<_i94.DebitBloc>(() => _i94.DebitBloc(
        addDebtUseCase: gh<_i95.AddDebitUseCase>(),
        getDebtUseCase: gh<_i95.GetDebitUseCase>(),
        getTransactionsUseCase: gh<_i95.GetDebitTransactionsUseCase>(),
        addTransactionUseCase: gh<_i95.AddDebitTransactionUseCase>(),
        updateDebtUseCase: gh<_i95.UpdateDebitUseCase>(),
        deleteDebtUseCase: gh<_i95.DeleteDebitUseCase>(),
        deleteDebitTransactionUseCase: gh<_i95.DeleteDebitTransactionUseCase>(),
        deleteDebitTransactionsByDebitIdUseCase:
            gh<_i49.DeleteDebitTransactionsByDebitIdUseCase>(),
      ));
  gh.factory<_i96.SearchCubit>(
      () => _i96.SearchCubit(gh<_i82.SearchUseCase>()));
  gh.factory<_i97.SettingCubit>(() => _i97.SettingCubit(
        gh<_i70.GetTransactionsUseCase>(),
        gh<_i72.GetDefaultCategoriesUseCase>(),
        gh<_i70.UpdateTransactionUseCase>(),
        gh<_i32.JSONFileImportUseCase>(),
        gh<_i32.JSONFileExportUseCase>(),
        gh<_i32.SettingsUseCase>(),
        gh<_i32.CSVFileExportUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i98.HiveBoxModule {}

class _$ServiceBoxModule extends _i99.ServiceBoxModule {}
