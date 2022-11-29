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
}
