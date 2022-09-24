import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../common/enum/box_types.dart';
import '../data/category/model/category.dart' as category;
import '../data/settings/settings_service.dart';
import '../main.dart';
import '../presentation/accounts/pages/add_account_page.dart';
import '../presentation/category/pages/add_category_page.dart';
import '../presentation/expense/pages/expense_page.dart';
import '../presentation/home/pages/home_page.dart';
import '../presentation/login/pages/user_image_page.dart';
import '../presentation/login/pages/user_name_page.dart';
import '../presentation/splash/pages/splash_screen_page.dart';

const splashPath = '/splash';
const userNamePath = '/user-name';
const userImagePath = '/user-image';
const landingPath = '/landing';
const loginPath = '/login';
const addExpensePath = 'add-expense';
const editExpensePath = 'edit-expense';
const addCategoryPath = 'add-category';
const addAccountPath = 'add-account';
const editAccountPath = 'edit-account';

final settings = Hive.box(BoxType.settings.stringValue);

final GoRouter goRouter = GoRouter(
  initialLocation: loginPath,
  errorBuilder: (context, state) => Center(
    child: Text(state.error.toString()),
  ),
  redirect: (_, state) {
    final isLogging = state.location == loginPath;
    final String name = settings.get(userNameKey, defaultValue: '');
    if (name.isEmpty && isLogging) {
      return userNamePath;
    }
    final String image = settings.get(userImageKey, defaultValue: '');
    if (image.isEmpty && isLogging) {
      return userImagePath;
    }
    final languageCode = settings.get(userLanguageKey, defaultValue: 'DEF');
    if (languageCode == 'DEF' && isLogging) {
      return splashPath;
    }
    if (name.isNotEmpty && image.isNotEmpty && isLogging) {
      currentLocale = languageCode;
      return landingPath;
    }
    return null;
  },
  refreshListenable: settings.listenable(),
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'login',
      path: loginPath,
      builder: (context, state) =>
          const Center(child: CircularProgressIndicator()),
    ),
    GoRoute(
      name: 'splash',
      path: splashPath,
      builder: (context, state) {
        if (state.extra is Map) {
          final map = state.extra as Map;
          return SplashScreenPage(
            forceChangeCurrency: map['force_change_currency'] as bool,
          );
        } else {
          return const SplashScreenPage();
        }
      },
    ),
    GoRoute(
      name: 'landing',
      path: landingPath,
      builder: (context, state) => const LandingPage(),
      routes: [
        GoRoute(
          path: addExpensePath,
          builder: (context, state) {
            return const ExpensePage();
          },
        ),
        GoRoute(
          name: editExpensePath,
          path: 'edit-expense/:eid',
          builder: (context, state) =>
              ExpensePage(expenseId: state.params['eid']),
        ),
        GoRoute(
          name: addCategoryPath,
          path: addCategoryPath,
          builder: (context, state) => AddCategoryPage(
            category: state.extra as category.Category?,
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
);
