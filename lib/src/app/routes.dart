import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/data/settings/authenticate.dart';

import '../core/common.dart';
import '../core/enum/box_types.dart';
import '../presentation/accounts/pages/add/add_account_page.dart';
import '../presentation/budget_overview/pages/expense_list_page.dart';
import '../presentation/category/pages/add/add_category_page.dart';
import '../presentation/debits/pages/add/add_debt_page.dart';
import '../presentation/debits/pages/debts_page.dart';
import '../presentation/expense/pages/expense_page.dart';
import '../presentation/home/pages/home_page.dart';
import '../presentation/login/intro/into_page.dart';
import '../presentation/login/pages/currency_selector_page.dart';
import '../presentation/login/pages/user_image_page.dart';
import '../presentation/login/pages/user_name_page.dart';
import '../presentation/settings/pages/export_and_import_page.dart';
import '../presentation/settings/pages/setting_page.dart';
import '../service_locator.dart';

const loginPath = '/login';
const loginName = 'login';

const splashPath = '/splash';
const splashName = 'splash';

const userNamePath = '/user-name';
const userImagePath = '/user-image';
const landingPath = '/landing';
const landingName = 'landing';

const addExpensePath = 'add-expense';
const editExpensePath = 'edit-expense';
const addCategoryPath = 'add-category';
const editCategoryPath = 'edit-category';
const addAccountPath = 'add-account';
const editAccountPath = 'edit-account';
const expensesByCategory = 'expenses';
const exportAndImport = 'export-import';
const settingsPath = 'settings';
const settingsName = 'settings';
const debtAddOrEditPath = 'edit-debt';
const debtPage = 'debt';
const addDebitName = 'debit-add';

const introPageName = 'intro';
const introPagePath = '/intro';

final settings = Hive.box(BoxType.settings.name);

final GoRouter goRouter = GoRouter(
  initialLocation: introPagePath,
  observers: [HeroController()],
  refreshListenable: settings.listenable(),
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: introPageName,
      path: introPagePath,
      builder: (context, state) => const IntroPage(),
    ),
    GoRoute(
      name: loginName,
      path: loginPath,
      builder: (context, state) =>
          const Center(child: CircularProgressIndicator()),
    ),
    GoRoute(
      name: splashName,
      path: splashPath,
      builder: (context, state) {
        if (state.extra is Map) {
          final map = state.extra as Map;
          return CurrencySelectorPage(
            forceChangeCurrency: map['force_change_currency'] as bool,
          );
        } else {
          return const CurrencySelectorPage();
        }
      },
    ),
    GoRoute(
      name: landingName,
      path: landingPath,
      builder: (context, state) => const LandingPage(),
      routes: [
        GoRoute(
          path: addExpensePath,
          name: addExpensePath,
          builder: (context, state) => const ExpensePage(),
        ),
        GoRoute(
          name: editExpensePath,
          path: 'edit-expense/:eid',
          builder: (context, state) => ExpensePage(
            expenseId: state.params['eid'],
          ),
        ),
        GoRoute(
          name: addCategoryPath,
          path: addCategoryPath,
          builder: (context, state) => const AddCategoryPage(),
        ),
        GoRoute(
          name: editCategoryPath,
          path: 'edit-category/:cid',
          builder: (context, state) => AddCategoryPage(
            categoryId: state.params['cid'],
          ),
        ),
        GoRoute(
          name: addAccountPath,
          path: addAccountPath,
          builder: (context, state) => const AddAccountPage(),
        ),
        GoRoute(
          name: editAccountPath,
          path: 'edit-account/:aid',
          builder: (context, state) => AddAccountPage(
            accountId: state.params['aid'],
          ),
        ),
        GoRoute(
          name: expensesByCategory,
          path: 'expenses/:cid',
          builder: (context, state) => ExpenseListPage(
            categoryId: state.params['cid'],
            accountLocalDataSource: locator.get(),
            categoryLocalDataSource: locator.get(),
          ),
        ),
        GoRoute(
          name: exportAndImport,
          path: exportAndImport,
          builder: (context, state) => const ExportAndImportPage(),
        ),
        GoRoute(
          name: settingsName,
          path: settingsPath,
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          name: addDebitName,
          path: addDebitName,
          builder: (context, state) => const AddOrEditDebtPage(),
        ),
        GoRoute(
          name: debtAddOrEditPath,
          path: 'debt/:did',
          builder: (context, state) => AddOrEditDebtPage(
            debtId: state.params['did'],
          ),
        ),
        GoRoute(
          name: debtPage,
          path: 'debt',
          builder: (context, state) => const DebtsPage(),
        ),
      ],
    ),
    GoRoute(
      name: 'user-name',
      path: userNamePath,
      builder: (context, state) => UserNamePage(),
    ),
    GoRoute(
      name: 'user-image',
      path: userImagePath,
      builder: (context, state) => const UserImagePage(),
    ),
  ],
  errorBuilder: (context, state) => Center(
    child: Text(state.error.toString()),
  ),
  redirect: (_, state) async {
    final isLogging = state.location == introPagePath;
    bool isIntroDone = settings.get(userIntroKey, defaultValue: false);
    if (!isIntroDone) {
      return introPagePath;
    }
    final String name = settings.get(userNameKey, defaultValue: '');
    if (name.isEmpty && isLogging) {
      return userNamePath;
    }
    final String image = settings.get(userImageKey, defaultValue: '');
    if (image.isEmpty && isLogging) {
      return userImagePath;
    }
    final String languageCode =
        settings.get(userLanguageKey, defaultValue: 'DEF');
    if (languageCode == 'DEF' && isLogging) {
      return splashPath;
    }
    if (settings.get(userAuthKey, defaultValue: false) &&
        name.isNotEmpty &&
        image.isNotEmpty &&
        isLogging) {
      final auth = await locator.getAsync<Authenticate>();
      final bool result = await auth.authenticateWithBiometrics();
      if (result) {
        return landingPath;
      }
    } else {
      if (name.isNotEmpty && image.isNotEmpty && isLogging) {
        return landingPath;
      }
    }
    return null;
  },
);
