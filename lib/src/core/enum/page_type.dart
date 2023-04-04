import 'package:flutter/material.dart';

import '../common.dart';

enum PageType {
  home,
  accounts,
  category,
  overview,
  debts,
  budget;

  int get toIndex {
    switch (this) {
      case PageType.home:
        return 0;
      case PageType.accounts:
        return 1;
      case PageType.category:
        return 2;
      case PageType.overview:
        return 3;
      case PageType.debts:
        return 4;
      case PageType.budget:
        return 5;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case PageType.home:
        return context.loc.homeLabel;
      case PageType.accounts:
        return context.loc.accountsLabel;
      case PageType.overview:
        return context.loc.overviewLabel;
      case PageType.category:
        return context.loc.categoriesLabel;
      case PageType.debts:
        return context.loc.debtsLabel;
      case PageType.budget:
        return context.loc.budgetLabel;
    }
  }
}
