// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/adapters.dart' as _i4;
import 'package:hive_flutter/hive_flutter.dart' as _i27;
import 'package:image_picker/image_picker.dart' as _i19;
import 'package:in_app_review/in_app_review.dart' as _i20;
import 'package:injectable/injectable.dart' as _i2;
import 'package:paisa/core/in_app.dart' as _i78;
import 'package:paisa/features/account/data/data_sources/local/account_data_manager.dart'
    as _i21;
import 'package:paisa/features/account/data/model/account_model.dart' as _i6;
import 'package:paisa/features/account/data/repository/account_repository_impl.dart'
    as _i42;
import 'package:paisa/features/account/domain/repository/account_repository.dart'
    as _i41;
import 'package:paisa/features/account/domain/use_case/account_use_case.dart'
    as _i76;
import 'package:paisa/features/account/domain/use_case/add_account_use_case.dart'
    as _i43;
import 'package:paisa/features/account/domain/use_case/delete_account_use_case.dart'
    as _i51;
import 'package:paisa/features/account/domain/use_case/get_account_use_case.dart'
    as _i63;
import 'package:paisa/features/account/domain/use_case/get_accounts_use_case.dart'
    as _i64;
import 'package:paisa/features/account/domain/use_case/update_account_use_case.dart'
    as _i88;
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart'
    as _i91;
import 'package:paisa/features/category/data/data_sources/local/category_data_source.dart'
    as _i22;
import 'package:paisa/features/category/data/model/category_model.dart' as _i7;
import 'package:paisa/features/category/data/repository/category_repository_impl.dart'
    as _i47;
import 'package:paisa/features/category/domain/repository/category_repository.dart'
    as _i46;
import 'package:paisa/features/category/domain/use_case/add_category_use_case.dart'
    as _i92;
import 'package:paisa/features/category/domain/use_case/category_use_case.dart'
    as _i75;
import 'package:paisa/features/category/domain/use_case/delete_category_use_case.dart'
    as _i52;
import 'package:paisa/features/category/domain/use_case/get_category_use_case.dart'
    as _i65;
import 'package:paisa/features/category/domain/use_case/get_default_categories_use_case.dart'
    as _i68;
import 'package:paisa/features/category/domain/use_case/update_category_use_case.dart'
    as _i89;
import 'package:paisa/features/category/presentation/bloc/category_bloc.dart'
    as _i96;
import 'package:paisa/features/country_picker/data/repository/country_repository_impl.dart'
    as _i16;
import 'package:paisa/features/country_picker/domain/repository/country_repository.dart'
    as _i15;
import 'package:paisa/features/country_picker/domain/use_case/get_contries_user_case.dart'
    as _i18;
import 'package:paisa/features/country_picker/presentation/cubit/country_picker_cubit.dart'
    as _i48;
import 'package:paisa/features/debit/data/data_sources/local/debit_local_data_source_impl.dart'
    as _i23;
import 'package:paisa/features/debit/data/models/debit_model.dart' as _i8;
import 'package:paisa/features/debit/data/models/debit_transactions_model.dart'
    as _i9;
import 'package:paisa/features/debit/data/repository/debit_repository_impl.dart'
    as _i50;
import 'package:paisa/features/debit/domain/repository/debit_repository.dart'
    as _i49;
import 'package:paisa/features/debit/domain/use_case/add_debit_transaction_use_case.dart'
    as _i93;
import 'package:paisa/features/debit/domain/use_case/add_debit_use.case.dart'
    as _i94;
import 'package:paisa/features/debit/domain/use_case/debit_use_case.dart'
    as _i98;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transaction_use_case.dart'
    as _i53;
import 'package:paisa/features/debit/domain/use_case/delete_debit_transactions_by_debit_id_use_case.dart'
    as _i54;
import 'package:paisa/features/debit/domain/use_case/delete_debit_use_case.dart'
    as _i55;
import 'package:paisa/features/debit/domain/use_case/get_debit_transactions_use_case.dart'
    as _i66;
import 'package:paisa/features/debit/domain/use_case/get_debit_use_case.dart'
    as _i67;
import 'package:paisa/features/debit/domain/use_case/update_debit_use.case.dart'
    as _i90;
import 'package:paisa/features/debit/presentation/cubit/debts_bloc.dart'
    as _i97;
import 'package:paisa/features/home/data/data_sources/combined_transaction_manager.dart'
    as _i11;
import 'package:paisa/features/home/data/repository/combined_transaction_repository_impl.dart'
    as _i13;
import 'package:paisa/features/home/domain/repository/combined_transaction_repository.dart'
    as _i12;
import 'package:paisa/features/home/domain/use_case/combined_transaction_use_case.dart'
    as _i14;
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart'
    as _i73;
import 'package:paisa/features/home/presentation/controller/summary_controller.dart'
    as _i35;
import 'package:paisa/features/home/presentation/cubit/overview/overview_cubit.dart'
    as _i81;
import 'package:paisa/features/home/presentation/cubit/summary/cubit/summary_cubit.dart'
    as _i37;
import 'package:paisa/features/profile/data/repository/profile_repository_impl.dart'
    as _i29;
import 'package:paisa/features/profile/domain/repository/profile_repository.dart'
    as _i28;
import 'package:paisa/features/profile/domain/use_case/image_picker_use_case.dart'
    as _i77;
import 'package:paisa/features/profile/domain/use_case/profile_use_case.dart'
    as _i83;
import 'package:paisa/features/profile/presentation/cubit/profile_cubit.dart'
    as _i82;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager.dart'
    as _i24;
import 'package:paisa/features/recurring/data/data_sources/local_recurring_data_manager_impl.dart'
    as _i25;
import 'package:paisa/features/recurring/data/model/recurring.dart' as _i10;
import 'package:paisa/features/recurring/data/repository/recurring_repository_impl.dart'
    as _i31;
import 'package:paisa/features/recurring/domain/repository/recurring_repository.dart'
    as _i30;
import 'package:paisa/features/recurring/domain/use_case/add_recurring_use_case.dart'
    as _i44;
import 'package:paisa/features/recurring/domain/use_case/recurring_use_case.dart'
    as _i85;
import 'package:paisa/features/recurring/presentation/cubit/recurring_cubit.dart'
    as _i84;
import 'package:paisa/features/search/domain/use_case/filter_expense_use_case.dart'
    as _i86;
import 'package:paisa/features/search/presentation/cubit/search_cubit.dart'
    as _i99;
import 'package:paisa/features/settings/data/authenticate.dart' as _i3;
import 'package:paisa/features/settings/data/file_handler.dart' as _i62;
import 'package:paisa/features/settings/data/repository/csv_export_impl.dart'
    as _i61;
import 'package:paisa/features/settings/data/repository/json_export_import_impl.dart'
    as _i60;
import 'package:paisa/features/settings/data/repository/settings_repository_impl.dart'
    as _i33;
import 'package:paisa/features/settings/domain/repository/import_export.dart'
    as _i59;
import 'package:paisa/features/settings/domain/repository/settings_repository.dart'
    as _i32;
import 'package:paisa/features/settings/domain/use_case/csv_file_export_use_case.dart'
    as _i95;
import 'package:paisa/features/settings/domain/use_case/json_file_export_use_case.dart'
    as _i79;
import 'package:paisa/features/settings/domain/use_case/json_file_import_use_case.dart'
    as _i80;
import 'package:paisa/features/settings/domain/use_case/setting_use_case.dart'
    as _i36;
import 'package:paisa/features/settings/domain/use_case/settings_use_case.dart'
    as _i34;
import 'package:paisa/features/settings/presentation/cubit/settings_cubit.dart'
    as _i100;
import 'package:paisa/features/transaction/data/data_sources/local/transaction_data_manager.dart'
    as _i26;
import 'package:paisa/features/transaction/data/model/transaction_model.dart'
    as _i5;
import 'package:paisa/features/transaction/data/repository/transaction_repository_impl.dart'
    as _i39;
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart'
    as _i38;
import 'package:paisa/features/transaction/domain/use_case/add_transaction_use_case.dart'
    as _i45;
import 'package:paisa/features/transaction/domain/use_case/delete_transaction_from_category_id_use_case.dart'
    as _i58;
import 'package:paisa/features/transaction/domain/use_case/delete_transaction_use_case.dart'
    as _i56;
import 'package:paisa/features/transaction/domain/use_case/delete_transactions_by_account_id_use_case.dart'
    as _i57;
import 'package:paisa/features/transaction/domain/use_case/get_transaction_use_case.dart'
    as _i69;
import 'package:paisa/features/transaction/domain/use_case/get_transactions_by_account_id_use_case.dart'
    as _i70;
import 'package:paisa/features/transaction/domain/use_case/get_transactions_by_category_id_use_case.dart'
    as _i71;
import 'package:paisa/features/transaction/domain/use_case/get_transactions_use_case.dart'
    as _i72;
import 'package:paisa/features/transaction/domain/use_case/transaction_use_case.dart'
    as _i74;
import 'package:paisa/features/transaction/domain/use_case/update_expense_use_case.dart'
    as _i40;
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i87;

import 'module/hive_module.dart' as _i101;
import 'module/service_module.dart' as _i102;

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
  gh.singleton<_i11.CombinedTransactionManager>(
      _i11.CombinedTransactionManagerImpl(
    gh<_i4.Box<_i5.TransactionModel>>(),
    gh<_i4.Box<_i6.AccountModel>>(),
    gh<_i4.Box<_i7.CategoryModel>>(),
  ));
  gh.singleton<_i12.CombinedTransactionRepository>(
      _i13.CombinedTransactionRepoImpl(gh<_i11.CombinedTransactionManager>()));
  gh.singleton<_i14.CombinedTransactionUseCase>(_i14.CombinedTransactionUseCase(
      gh<_i12.CombinedTransactionRepository>()));
  gh.singleton<_i15.CountryRepository>(_i16.CountryRepositoryImpl());
  gh.singleton<_i17.DeviceInfoPlugin>(
      serviceBoxModule.providesDeviceInfoPlugin());
  gh.factory<_i18.GetCountriesUseCase>(
      () => _i18.GetCountriesUseCase(repository: gh<_i15.CountryRepository>()));
  gh.singleton<_i19.ImagePicker>(serviceBoxModule.providesImagePicker());
  gh.singleton<_i20.InAppReview>(serviceBoxModule.providesInAppReview());
  gh.singleton<_i21.LocalAccountManager>(_i21.LocalAccountManagerImpl(
      accountBox: gh<_i4.Box<_i6.AccountModel>>()));
  gh.singleton<_i22.LocalCategoryManager>(
      _i22.LocalCategoryManagerDataSourceImpl(
          gh<_i4.Box<_i7.CategoryModel>>()));
  gh.singleton<_i23.LocalDebitDataSource>(_i23.LocalDebitDataSourceImpl(
    debtBox: gh<_i4.Box<_i8.DebitModel>>(),
    transactionsBox: gh<_i4.Box<_i9.DebitTransactionsModel>>(),
  ));
  gh.factory<_i24.LocalRecurringDataManager>(() =>
      _i25.LocalRecurringDataManagerImpl(gh<_i4.Box<_i10.RecurringModel>>()));
  gh.factory<_i26.LocalTransactionManager>(() =>
      _i26.LocalTransactionManagerImpl(gh<_i27.Box<_i5.TransactionModel>>()));
  gh.singleton<_i28.ProfileRepository>(_i29.ProfileRepositoryImpl(
    gh<_i19.ImagePicker>(),
    gh<_i4.Box<dynamic>>(instanceName: 'settings'),
  ));
  gh.singleton<_i30.RecurringRepository>(_i31.RecurringRepositoryImpl(
    gh<_i24.LocalRecurringDataManager>(),
    gh<_i26.LocalTransactionManager>(),
  ));
  gh.factory<_i32.SettingsRepository>(() => _i33.SettingsRepositoryImpl(
      gh<_i4.Box<dynamic>>(instanceName: 'settings')));
  gh.singleton<_i34.SettingsUseCase>(
      _i34.SettingsUseCase(gh<_i32.SettingsRepository>()));
  gh.singleton<_i35.SummaryController>(
      _i35.SummaryController(gh<_i36.SettingsUseCase>()));
  gh.factory<_i37.SummaryCubit>(
      () => _i37.SummaryCubit(gh<_i14.CombinedTransactionUseCase>()));
  gh.singleton<_i38.TransactionRepository>(_i39.ExpenseRepositoryImpl(
      dataSource: gh<_i26.LocalTransactionManager>()));
  gh.singleton<_i40.UpdateTransactionUseCase>(_i40.UpdateTransactionUseCase(
      expenseRepository: gh<_i38.TransactionRepository>()));
  gh.singleton<_i41.AccountRepository>(
      _i42.AccountRepositoryImpl(dataSource: gh<_i21.LocalAccountManager>()));
  gh.singleton<_i43.AddAccountUseCase>(
      _i43.AddAccountUseCase(accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i44.AddRecurringUseCase>(
      _i44.AddRecurringUseCase(gh<_i30.RecurringRepository>()));
  gh.singleton<_i45.AddTransactionUseCase>(_i45.AddTransactionUseCase(
      expenseRepository: gh<_i38.TransactionRepository>()));
  gh.singleton<_i46.CategoryRepository>(_i47.CategoryRepositoryImpl(
    dataSources: gh<_i22.LocalCategoryManager>(),
    expenseDataManager: gh<_i26.LocalTransactionManager>(),
  ));
  gh.factory<_i48.CountryPickerCubit>(() => _i48.CountryPickerCubit(
        gh<_i18.GetCountriesUseCase>(),
        gh<_i36.SettingsUseCase>(),
      ));
  gh.singleton<_i49.DebitRepository>(
      _i50.DebtRepositoryImpl(dataSource: gh<_i23.LocalDebitDataSource>()));
  gh.singleton<_i51.DeleteAccountUseCase>(_i51.DeleteAccountUseCase(
      accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i52.DeleteCategoryUseCase>(_i52.DeleteCategoryUseCase(
      categoryRepository: gh<_i46.CategoryRepository>()));
  gh.singleton<_i53.DeleteDebitTransactionUseCase>(
      _i53.DeleteDebitTransactionUseCase(
          debtRepository: gh<_i49.DebitRepository>()));
  gh.singleton<_i54.DeleteDebitTransactionsByDebitIdUseCase>(
      _i54.DeleteDebitTransactionsByDebitIdUseCase(
          debtRepository: gh<_i49.DebitRepository>()));
  gh.singleton<_i55.DeleteDebitUseCase>(
      _i55.DeleteDebitUseCase(debtRepository: gh<_i49.DebitRepository>()));
  gh.singleton<_i56.DeleteTransactionUseCase>(_i56.DeleteTransactionUseCase(
      expenseRepository: gh<_i38.TransactionRepository>()));
  gh.singleton<_i57.DeleteTransactionsByAccountIdUseCase>(
      _i57.DeleteTransactionsByAccountIdUseCase(
          expenseRepository: gh<_i38.TransactionRepository>()));
  gh.singleton<_i58.DeleteTransactionsByCategoryIdUseCase>(
      _i58.DeleteTransactionsByCategoryIdUseCase(
          transactionRepository: gh<_i38.TransactionRepository>()));
  gh.lazySingleton<_i59.Export>(
    () => _i60.JSONExportImpl(
      gh<_i21.LocalAccountManager>(),
      gh<_i22.LocalCategoryManager>(),
      gh<_i26.LocalTransactionManager>(),
    ),
    instanceName: 'json_export',
  );
  gh.lazySingleton<_i59.Export>(
    () => _i61.CSVExport(
      gh<_i17.DeviceInfoPlugin>(),
      gh<_i21.LocalAccountManager>(),
      gh<_i22.LocalCategoryManager>(),
      gh<_i26.LocalTransactionManager>(),
    ),
    instanceName: 'csv',
  );
  gh.singleton<_i62.FileHandler>(_i62.FileHandler(
    gh<_i17.DeviceInfoPlugin>(),
    gh<_i21.LocalAccountManager>(),
    gh<_i22.LocalCategoryManager>(),
    gh<_i26.LocalTransactionManager>(),
  ));
  gh.singleton<_i63.GetAccountUseCase>(
      _i63.GetAccountUseCase(accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i64.GetAccountsUseCase>(
      _i64.GetAccountsUseCase(accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i65.GetCategoryUseCase>(_i65.GetCategoryUseCase(
      categoryRepository: gh<_i46.CategoryRepository>()));
  gh.singleton<_i66.GetDebitTransactionsUseCase>(
      _i66.GetDebitTransactionsUseCase(
          debtRepository: gh<_i49.DebitRepository>()));
  gh.singleton<_i67.GetDebitUseCase>(
      _i67.GetDebitUseCase(debtRepository: gh<_i49.DebitRepository>()));
  gh.singleton<_i68.GetDefaultCategoriesUseCase>(
      _i68.GetDefaultCategoriesUseCase(
          categoryRepository: gh<_i46.CategoryRepository>()));
  gh.singleton<_i69.GetTransactionUseCase>(_i69.GetTransactionUseCase(
      transactionRepository: gh<_i38.TransactionRepository>()));
  gh.singleton<_i70.GetTransactionsByAccountIdUseCase>(
      _i70.GetTransactionsByAccountIdUseCase(
          expenseRepository: gh<_i38.TransactionRepository>()));
  gh.singleton<_i71.GetTransactionsByCategoryIdUseCase>(
      _i71.GetTransactionsByCategoryIdUseCase(
          expenseRepository: gh<_i38.TransactionRepository>()));
  gh.singleton<_i72.GetTransactionsUseCase>(_i72.GetTransactionsUseCase(
      expenseRepository: gh<_i38.TransactionRepository>()));
  gh.factory<_i73.HomeBloc>(() => _i73.HomeBloc(
        gh<_i74.GetTransactionsUseCase>(),
        gh<_i75.GetDefaultCategoriesUseCase>(),
        gh<_i76.GetAccountUseCase>(),
        gh<_i75.GetCategoryUseCase>(),
        gh<_i74.GetTransactionsByCategoryIdUseCase>(),
      ));
  gh.singleton<_i77.ImagePickerUseCase>(
      _i77.ImagePickerUseCase(gh<_i28.ProfileRepository>()));
  gh.lazySingleton<_i59.Import>(
    () => _i60.JSONImportImpl(
      gh<_i17.DeviceInfoPlugin>(),
      gh<_i21.LocalAccountManager>(),
      gh<_i22.LocalCategoryManager>(),
      gh<_i26.LocalTransactionManager>(),
    ),
    instanceName: 'json_import',
  );
  gh.singleton<_i78.InApp>(_i78.InApp(gh<_i20.InAppReview>()));
  gh.singleton<_i79.JSONFileExportUseCase>(_i79.JSONFileExportUseCase(
    gh<_i32.SettingsRepository>(),
    gh<_i59.Export>(instanceName: 'json_export'),
  ));
  gh.singleton<_i80.JSONFileImportUseCase>(_i80.JSONFileImportUseCase(
    gh<_i32.SettingsRepository>(),
    gh<_i59.Import>(instanceName: 'json_import'),
  ));
  gh.factory<_i81.OverviewCubit>(() => _i81.OverviewCubit(
        gh<_i74.GetTransactionsUseCase>(),
        gh<_i75.GetCategoryUseCase>(),
        gh<_i75.GetDefaultCategoriesUseCase>(),
      ));
  gh.factory<_i82.ProfileCubit>(() => _i82.ProfileCubit(
        gh<_i83.ImagePickerUseCase>(),
        gh<_i4.Box<dynamic>>(instanceName: 'settings'),
      ));
  gh.factory<_i84.RecurringCubit>(
      () => _i84.RecurringCubit(gh<_i85.AddRecurringUseCase>()));
  gh.singleton<_i86.SearchUseCase>(
      _i86.SearchUseCase(gh<_i38.TransactionRepository>()));
  gh.factory<_i87.TransactionBloc>(() => _i87.TransactionBloc(
        gh<_i34.SettingsUseCase>(),
        getTransactionUseCase: gh<_i74.GetTransactionUseCase>(),
        accountUseCase: gh<_i76.GetAccountUseCase>(),
        addTransactionUseCase: gh<_i74.AddTransactionUseCase>(),
        deleteTransactionUseCase: gh<_i74.DeleteTransactionUseCase>(),
        updateTransactionUseCase: gh<_i74.UpdateTransactionUseCase>(),
        accountsUseCase: gh<_i76.GetAccountsUseCase>(),
        getDefaultCategoriesUseCase: gh<_i75.GetDefaultCategoriesUseCase>(),
      ));
  gh.singleton<_i88.UpdateAccountUseCase>(_i88.UpdateAccountUseCase(
      accountRepository: gh<_i41.AccountRepository>()));
  gh.singleton<_i89.UpdateCategoryUseCase>(_i89.UpdateCategoryUseCase(
      categoryRepository: gh<_i46.CategoryRepository>()));
  gh.singleton<_i90.UpdateDebitUseCase>(
      _i90.UpdateDebitUseCase(debtRepository: gh<_i49.DebitRepository>()));
  gh.factory<_i91.AccountBloc>(() => _i91.AccountBloc(
        getAccountUseCase: gh<_i76.GetAccountUseCase>(),
        deleteAccountUseCase: gh<_i76.DeleteAccountUseCase>(),
        getTransactionsByAccountIdUseCase:
            gh<_i74.GetTransactionsByAccountIdUseCase>(),
        addAccountUseCase: gh<_i76.AddAccountUseCase>(),
        getCategoryUseCase: gh<_i65.GetCategoryUseCase>(),
        deleteExpensesFromAccountIdUseCase:
            gh<_i74.DeleteTransactionsByAccountIdUseCase>(),
        updateAccountUseCase: gh<_i76.UpdateAccountUseCase>(),
      ));
  gh.singleton<_i92.AddCategoryUseCase>(_i92.AddCategoryUseCase(
      categoryRepository: gh<_i46.CategoryRepository>()));
  gh.singleton<_i93.AddDebitTransactionUseCase>(_i93.AddDebitTransactionUseCase(
      debtRepository: gh<_i49.DebitRepository>()));
  gh.singleton<_i94.AddDebitUseCase>(
      _i94.AddDebitUseCase(debtRepository: gh<_i49.DebitRepository>()));
  gh.singleton<_i95.CSVFileExportUseCase>(_i95.CSVFileExportUseCase(
    gh<_i32.SettingsRepository>(),
    gh<_i59.Export>(instanceName: 'csv'),
  ));
  gh.factory<_i96.CategoryBloc>(() => _i96.CategoryBloc(
        getCategoryUseCase: gh<_i75.GetCategoryUseCase>(),
        addCategoryUseCase: gh<_i75.AddCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i75.DeleteCategoryUseCase>(),
        deleteExpensesFromCategoryIdUseCase:
            gh<_i74.DeleteTransactionsByCategoryIdUseCase>(),
        updateCategoryUseCase: gh<_i75.UpdateCategoryUseCase>(),
      ));
  gh.factory<_i97.DebitBloc>(() => _i97.DebitBloc(
        addDebtUseCase: gh<_i98.AddDebitUseCase>(),
        getDebtUseCase: gh<_i98.GetDebitUseCase>(),
        getTransactionsUseCase: gh<_i98.GetDebitTransactionsUseCase>(),
        addTransactionUseCase: gh<_i98.AddDebitTransactionUseCase>(),
        updateDebtUseCase: gh<_i98.UpdateDebitUseCase>(),
        deleteDebtUseCase: gh<_i98.DeleteDebitUseCase>(),
        deleteDebitTransactionUseCase: gh<_i98.DeleteDebitTransactionUseCase>(),
        deleteDebitTransactionsByDebitIdUseCase:
            gh<_i54.DeleteDebitTransactionsByDebitIdUseCase>(),
      ));
  gh.factory<_i99.SearchCubit>(
      () => _i99.SearchCubit(gh<_i86.SearchUseCase>()));
  gh.factory<_i100.SettingCubit>(() => _i100.SettingCubit(
        gh<_i74.GetTransactionsUseCase>(),
        gh<_i75.GetDefaultCategoriesUseCase>(),
        gh<_i74.UpdateTransactionUseCase>(),
        gh<_i36.JSONFileImportUseCase>(),
        gh<_i36.JSONFileExportUseCase>(),
        gh<_i36.SettingsUseCase>(),
        gh<_i36.CSVFileExportUseCase>(),
      ));
  return getIt;
}

class _$HiveBoxModule extends _i101.HiveBoxModule {}

class _$ServiceBoxModule extends _i102.ServiceBoxModule {}
