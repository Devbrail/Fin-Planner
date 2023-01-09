import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum PageType { home, accounts, category, budgetOverview, debts }

extension MapPaisaPage on PageType {
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
        return AppLocalizations.of(context)!.homeLabel;
      case PageType.accounts:
        return AppLocalizations.of(context)!.accountsLabel;
      case PageType.budgetOverview:
        return AppLocalizations.of(context)!.budgetOverViewLabel;
      case PageType.category:
        return AppLocalizations.of(context)!.categoryLabel;
      case PageType.debts:
        return AppLocalizations.of(context)!.debtsLabel;
    }
  }
}
