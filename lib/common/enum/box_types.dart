enum BoxType { expense, accounts, category, settings }

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
    }
  }
}
