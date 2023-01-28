import 'package:flutter/material.dart';

import '../common.dart';

enum PageType {
  home,
  accounts,
  category,
  budgetOverview,
  debts;

  int get toIndex {
    switch (this) {
      case PageType.home:
        return 0;
      case PageType.accounts:
        return 1;
      case PageType.category:
        return 2;
      case PageType.budgetOverview:
        return 3;
      case PageType.debts:
        return 4;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case PageType.home:
        return context.loc.homeLabel;
      case PageType.accounts:
        return context.loc.accountsLabel;
      case PageType.budgetOverview:
        return context.loc.budgetOverViewLabel;
      case PageType.category:
        return context.loc.categoryLabel;
      case PageType.debts:
        return context.loc.debtsLabel;
    }
  }
}
