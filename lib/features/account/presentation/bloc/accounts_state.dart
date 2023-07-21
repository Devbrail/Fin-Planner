part of 'accounts_bloc.dart';

@immutable
abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountsInitial extends AccountState {}

class AccountListState extends AccountState {
  const AccountListState(this.accounts);

  final List<AccountEntity> accounts;

  @override
  List<Object> get props => [accounts];
}

class AccountAddedState extends AccountState {
  const AccountAddedState({this.isAddOrUpdate = false});

  final bool isAddOrUpdate;

  @override
  List<Object> get props => [isAddOrUpdate];
}

class AccountDeletedState extends AccountState {}

class AccountSelectedState extends AccountState {
  const AccountSelectedState(this.account, this.expenses);

  final AccountEntity account;
  final List<TransactionEntity> expenses;

  @override
  List<Object> get props => [account, expenses];
}

class AccountErrorState extends AccountState {
  const AccountErrorState(this.errorString);

  final String errorString;

  @override
  List<Object> get props => [errorString];
}

class AccountSuccessState extends AccountState {
  const AccountSuccessState(this.account);

  final AccountEntity account;

  @override
  List<Object> get props => [account];
}

class UpdateCardTypeState extends AccountState {
  const UpdateCardTypeState(this.cardType);

  final CardType cardType;

  @override
  List<Object> get props => [cardType];
}

class ExpensesFromAccountIdState extends AccountState {
  const ExpensesFromAccountIdState(this.expenses);

  final List<TransactionEntity> expenses;

  @override
  List<Object> get props => [expenses];
}

class AccountColorSelectedState extends AccountState {
  const AccountColorSelectedState(this.categoryColor);

  final int categoryColor;

  @override
  List<Object> get props => [categoryColor, identityHashCode(this)];
}

class AccountAndExpensesState extends AccountState {
  const AccountAndExpensesState(this.account, this.expenses);

  final AccountEntity account;
  final List<TransactionEntity> expenses;

  @override
  List<Object> get props => [account, expenses];
}
