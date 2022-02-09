import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_strategy/url_strategy.dart';

import '../common/enum/box_types.dart';
import '../common/enum/card_type.dart';
import '../common/enum/transaction.dart';
import '../data/accounts/datasources/account_data_source.dart';
import '../data/accounts/datasources/account_local_data_source.dart';
import '../data/accounts/model/account.dart';
import '../data/accounts/repository/account_repository_impl.dart';
import '../data/category/datasources/category_datasource.dart';
import '../data/category/datasources/category_local_data_source.dart';
import '../data/category/model/category.dart';
import '../data/category/repository/category_repository_impl.dart';
import '../data/expense/datasources/expense_manager_data_source.dart';
import '../data/expense/datasources/expsene_manager_local_data_source.dart';
import '../data/expense/model/expense.dart';
import '../data/expense/repository/expense_repository_impl.dart';
import '../data/local_auth/local_auth_api.dart';
import '../data/notification/notification_service.dart';
import '../data/settings/settings_service.dart';
import '../domain/account/repository/account_repository.dart';
import '../domain/account/usecase/account_use_case.dart';
import '../domain/category/repository/category_repository.dart';
import '../domain/category/usecase/category_use_case.dart';
import '../domain/landing/repository/expense_repository.dart';
import '../domain/landing/usecase/expense_use_case.dart';
import '../presentation/accounts/bloc/accounts_bloc.dart';
import '../presentation/category/bloc/category_bloc.dart';
import '../presentation/expense/bloc/expense_bloc.dart';
import '../presentation/home/bloc/home_bloc.dart';
import '../presentation/settings/bloc/settings_controller.dart';
import '../presentation/splash/cubit/splash_cubit.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  setPathUrlStrategy();
  await _setupHive();
  _localSoruces();
  await _setupNotification();
  _setupRepository();
  _setupUseCase();
  _setupBloc();
  await _setupController();
  _setupLocalAuth();
}

void _setupLocalAuth() {
  locator.registerSingleton<LocalAuthApi>(LocalAuthApi());
}

Future<void> _setupNotification() async {
  final service = NotificationService();
  await service.init();
  locator.registerSingleton<NotificationService>(service);
}

Future<void> _setupController() async {
  final controller = SettingsController(
    settingsService: locator.get(),
  );
  await controller.loadSettings();
  locator.registerFactory(() => controller);
}

Future<void> _setupHive() async {
  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);

  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(TransactonTypeAdapter());
  Hive.registerAdapter(CardTypeAdapter());
  await Hive.openBox<Expense>(BoxType.expense.stringValue);
  await Hive.openBox<Category>(BoxType.category.stringValue);
  await Hive.openBox<Account>(BoxType.accounts.stringValue);
  await Hive.openBox(BoxType.settings.stringValue);
}

void _localSoruces() {
  locator.registerSingleton<ExpenseManagerDataSource>(
      ExpenseManagerLocalDataSource());
  locator.registerSingleton<CategoryDataSource>(CategoryLocalDataSources());
  locator.registerSingleton<AccountDataSource>(AccountLocalDataSource());
  locator.registerSingleton<SettingsService>(SettingsServiceImpl());
}

void _setupRepository() {
  locator.registerSingleton<ExpenseRepository>(
    ExpenseRepositoryImpl(
      dataSource: locator.get(),
    ),
  );
  locator.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(
      dataSources: locator.get(),
    ),
  );
  locator.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(
      dataSource: locator.get(),
    ),
  );
}

void _setupUseCase() {
  locator.registerSingleton(
    ExpenseUseCase(expenseRepository: locator.get()),
  );

  locator.registerSingleton(
    CategoryUseCase(categoryRepository: locator.get()),
  );
  locator.registerSingleton(
    AccountUseCase(repository: locator.get()),
  );
}

void _setupBloc() {
  locator.registerFactory(() => SplashCubit());
  locator.registerFactory(() => CategoryBloc(categoryUseCase: locator.get()));
  locator.registerFactory(() => ExpenseBloc(locator.get()));
  locator.registerFactory(
    () => AccountsBloc(
      accountUseCase: locator.get(),
      expenseUseCase: locator.get(),
    ),
  );
  locator.registerFactory(() => HomeBloc());
}
