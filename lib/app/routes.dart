import 'package:flutter/material.dart';
import 'package:flutter_paisa/presentation/login/pages/user_image.dart';
import 'package:flutter_paisa/presentation/login/pages/user_name.dart';

import '../data/accounts/model/account.dart';
import '../data/category/model/category.dart';
import '../data/expense/model/expense.dart';
import '../presentation/accounts/pages/add_account_page.dart';
import '../presentation/category/pages/add_category_page.dart';
import '../presentation/expense/pages/expense_page.dart';
import '../presentation/home/pages/home_page.dart';
import '../presentation/settings/widgets/user_profile_widget.dart';
import '../presentation/splash/pages/splash_screen_page.dart';

const splashScreen = '/splash';
const userNameScreen = '/user-name';
const userImageScreen = '/user-image';
const landingScreen = '/landing';
const addExpenseScreen = '/add-expense';
const addCategoryScreen = '/add-category';
const addAccountCardScreen = '/add-card';
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
