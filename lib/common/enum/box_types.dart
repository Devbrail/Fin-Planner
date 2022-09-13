enum BoxType { expense, accounts, category, settings, goals }

extension BoxTypeMapping on BoxType {
  String get stringValue {
    switch (this) {
      case BoxType.accounts:
        return 'accounts';
      case BoxType.category:
        return 'category';
      case BoxType.expense:
        return 'expense';
      case BoxType.settings:
        return 'settings';
      case BoxType.goals:
        return 'goals';
    }
  }
}
