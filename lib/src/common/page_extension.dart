enum PaisaPage { home, accounts, category, budgetOverview, debts }

extension MapPaisaPage on PaisaPage {
  int get toIndex {
    switch (this) {
      case PaisaPage.home:
        return 0;
      case PaisaPage.accounts:
        return 1;
      case PaisaPage.category:
        return 2;
      case PaisaPage.budgetOverview:
        return 3;
      case PaisaPage.debts:
        return 4;
    }
  }
}
