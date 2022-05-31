import 'package:flutter/material.dart';
import 'package:flutter_paisa/presentation/login/pages/user_image.dart';
import 'package:flutter_paisa/presentation/login/pages/user_name.dart';
import 'package:go_router/go_router.dart';

import '../data/accounts/model/account.dart';
import '../data/category/model/category.dart';
import '../data/expense/model/expense.dart';
import '../presentation/accounts/pages/add_account_page.dart';
import '../presentation/category/pages/add_category_page.dart';
import '../presentation/expense/pages/expense_page.dart';
import '../presentation/home/pages/home_page.dart';
import '../presentation/settings/widgets/user_profile_widget.dart';
import '../presentation/splash/pages/splash_screen_page.dart';

const splashScreen = '/';
const userNameScreen = '/user-name';
const userImageScreen = '/user-image';
const landingScreen = '/landing';
const addExpenseScreen = 'add-expense';
const addCategoryScreen = 'add-category';
const addAccountCardScreen = 'add-card';
const profileScreen = '/profile';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreen:
      return _page(const SplashScreenPage());
    case landingScreen:
      return _page(const LandingPage());
    case addExpenseScreen:
      final args = settings.arguments as Expense?;
      return MaterialPageRoute(
        builder: (context) => ExpensePage(expense: args),
      );
    case addCategoryScreen:
      final args = settings.arguments as Category?;
      return _page(AddCategoryPage(category: args));
    case addAccountCardScreen:
      final args = settings.arguments as Account?;
      return _page(
        AddAccountPage(account: args),
      );
    case profileScreen:
      return _page(const UserProfilePage());
    case userNameScreen:
      return _page(UserNamePage());
    case userImageScreen:
      return _page(const UserImagePage());
    default:
      return _page(const UserProfilePage());
  }
}

PageRoute _page(Widget page) {
  return MaterialPageRoute(builder: (_) => page);
}

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      name: 'splash',
      path: splashScreen,
      builder: (context, state) => const SplashScreenPage(),
    ),
    GoRoute(
      name: 'landing',
      path: landingScreen,
      builder: (context, state) => const LandingPage(),
      routes: [
        GoRoute(
          path: addExpenseScreen,
          name: addExpenseScreen,
          builder: (context, state) => ExpensePage(
            expense: state.extra as Expense?,
          ),
        ),
        GoRoute(
          path: addCategoryScreen,
          name: addCategoryScreen,
          builder: (context, state) => AddCategoryPage(
            category: state.extra as Category?,
          ),
        ),
        GoRoute(
          path: addAccountCardScreen,
          name: addAccountCardScreen,
          builder: (context, state) => AddAccountPage(
            account: state.extra as Account?,
          ),
        ),
      ],
    ),
    GoRoute(
      path: profileScreen,
      builder: (context, state) => const UserProfilePage(),
    ),
    GoRoute(
      path: userNameScreen,
      builder: (context, state) => UserNamePage(),
    ),
    GoRoute(
      path: userImageScreen,
      builder: (context, state) => const UserImagePage(),
    ),
  ],
  initialLocation: splashScreen,
  errorBuilder: (context, state) => Center(
    child: Text(state.error.toString()),
  ),
);
