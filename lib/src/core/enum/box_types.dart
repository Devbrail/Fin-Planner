enum BoxType {
  expense('expense'),
  accounts('accounts'),
  category('category'),
  settings('settings'),
  debts('debts'),
  transactions('transactions');

  final String name;

  const BoxType(this.name);
}
