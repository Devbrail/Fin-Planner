import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/core/enum/transaction.dart';
import 'package:paisa/src/presentation/overview/pages/expense_list_page.dart';
import 'package:paisa/src/presentation/settings/pages/recurring_transactions_page.dart';

import '../../main.dart';
import '../core/common.dart';
import '../core/enum/box_types.dart';
import '../data/settings/authenticate.dart';
import '../presentation/accounts/pages/accounts_new/account_transaction_page.dart';
import '../presentation/accounts/pages/add/add_account_page.dart';
import '../presentation/category/pages/add/add_category_page.dart';
import '../presentation/category/pages/category_list_page.dart';
import '../presentation/currency_selector/pages/currency_selector_page.dart';
import '../presentation/debits/pages/add/add_debt_page.dart';
import '../presentation/debits/pages/debts_page.dart';
import '../presentation/expense/pages/expense_page.dart';
import '../presentation/home/pages/home_page.dart';
import '../presentation/login/intro/into_page.dart';
import '../presentation/login/pages/user_image_page.dart';
import '../presentation/login/pages/user_name_page.dart';
import '../presentation/search/pages/search_page.dart';
import '../presentation/settings/pages/export_and_import_page.dart';
import '../presentation/settings/pages/setting_page.dart';

const loginPath = '/login';
const loginName = 'login';

const splashPath = '/splash';
const splashName = 'splash';

const userNamePath = '/user-name';
const userImagePath = '/user-image';
const landingPath = '/landing';
const landingName = 'landing';
const searchPath = 'search';
const search = 'search';
const shortcutAddExpensePath = 'short-cut-add-expense';
const addExpensePath = 'add-expense';
const editExpensePath = 'edit-expense';
const addCategoryPath = 'add-category';
const editCategoryPath = 'edit-category';
const addAccountPath = 'add-account';
const editAccountPath = 'edit-account';
const accountTransactionPath = 'account-transaction';
const expensesByCategory = 'expenses';
const exportAndImport = 'export-import';
const recurringTransactionsPath = 'recurring';
const settingsPath = 'settings';
const settingsName = 'settings';
const debtAddOrEditPath = 'edit-debt';
const debtPage = 'debt';
const addDebitName = 'debit-add';
const manageCategories = 'categories';

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
          return CurrencySelectorPage();
        }
      },
    ),
    GoRoute(
      name: landingName,
      path: landingPath,
      builder: (context, state) => const LandingPage(),
      routes: [
        GoRoute(
          path: 'short-cut-add-expense/:type',
          name: shortcutAddExpensePath,
          pageBuilder: (context, state) {
            String? transactionTypeString = state.params['type'];
            int transactionType =
                int.tryParse(transactionTypeString ?? '') ?? 0;
            return MaterialPage(
              key: ValueKey(
                state.location +
                    DateTime.now().millisecondsSinceEpoch.toString(),
              ),
              child: ExpensePage(
                transactionType: TransactionType.values[transactionType],
              ),
            );
          },
        ),
        GoRoute(
          path: addExpensePath,
          name: addExpensePath,
          pageBuilder: (context, state) => MaterialPage(
            key: ValueKey(
              state.location + DateTime.now().millisecondsSinceEpoch.toString(),
            ),
            child: const ExpensePage(),
          ),
        ),
        GoRoute(
          name: editExpensePath,
          path: 'edit-expense/:eid',
          pageBuilder: (context, state) => MaterialPage(
            key: ValueKey(
              state.location + DateTime.now().millisecondsSinceEpoch.toString(),
            ),
            child: ExpensePage(
              expenseId: state.params['eid'],
            ),
          ),
        ),
        GoRoute(
          name: addCategoryPath,
          path: addCategoryPath,
          builder: (context, state) => const AddCategoryPage(),
        ),
        GoRoute(
          name: manageCategories,
          path: manageCategories,
          builder: (context, state) => const CategoryListPage(),
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
          name: accountTransactionPath,
          path: 'account/:aid',
          builder: (context, state) => AccountTransactionPage(
            accountId: state.params['aid'] as String,
          ),
        ),
        GoRoute(
          name: expensesByCategory,
          path: 'expenses/:cid',
          builder: (context, state) => ExpenseListPage(
            categoryId: state.params['cid'] as String,
            accountLocalDataSource: getIt.get(),
            categoryLocalDataSource: getIt.get(),
            expenseDataManager: getIt.get(),
          ),
        ),
        GoRoute(
          name: settingsName,
          path: settingsPath,
          builder: (context, state) => const SettingsPage(),
          routes: [
            GoRoute(
              name: exportAndImport,
              path: exportAndImport,
              builder: (context, state) => const ExportAndImportPage(),
            ),
            GoRoute(
              name: recurringTransactionsPath,
              path: recurringTransactionsPath,
              builder: (context, state) => const RecurringTransactionPage(),
            ),
          ],
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
        GoRoute(
          name: search,
          path: searchPath,
          builder: (context, state) => const SearchPage(),
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
    final isBiometricEnabled = settings.get(userAuthKey, defaultValue: false);
    if (isBiometricEnabled &&
        name.isNotEmpty &&
        image.isNotEmpty &&
        isLogging) {
      final localAuth = getIt.get<Authenticate>();

      final bool canCheckBiometrics = await localAuth.canCheckBiometrics();

      if (canCheckBiometrics) {
        final bool result = await localAuth.authenticateWithBiometrics();
        if (result) {
          return landingPath;
        } else {
          SystemNavigator.pop();
        }
      }
    } else if (name.isNotEmpty && image.isNotEmpty && isLogging) {
      return landingPath;
    }
    return null;
  },
);
