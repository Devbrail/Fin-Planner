part of 'accounts_bloc.dart';

@immutable
abstract class AccountsState extends Equatable {
  const AccountsState();

  @override
  List<Object> get props => [];
}

class AccountsInitial extends AccountsState {}

class AccountListState extends AccountsState {
  final List<Account> accounts;

  const AccountListState(this.accounts);

  @override
  List<Object> get props => [accounts];
}

class AccountAddedState extends AccountsState {
  final bool isAddOrUpdate;

  const AccountAddedState({this.isAddOrUpdate = false});
  @override
  List<Object> get props => [isAddOrUpdate];
}

class AccountDeletedState extends AccountsState {}

class AccountSelectedState extends AccountsState {
  final Account account;

  const AccountSelectedState(this.account);

  @override
  List<Object> get props => [account];
}

class AccountErrorState extends AccountsState {
  final String errorString;

  const AccountErrorState(this.errorString);

  @override
  List<Object> get props => [errorString];
}

class AccountSuccessState extends AccountsState {
  final Account account;

  const AccountSuccessState(this.account);

  @override
  List<Object> get props => [account];
}

class UpdateCardTypeState extends AccountsState {
  final CardType cardType;

  const UpdateCardTypeState(this.cardType);

  @override
  List<Object> get props => [cardType];
}

class ExpensesFromAccountIdState extends AccountsState {
  final List<Expense> expenses;

  const ExpensesFromAccountIdState(this.expenses);

  @override
  List<Object> get props => [expenses];
}

class AccountColorSelectedState extends AccountsState {
  final int categoryColor;

  const AccountColorSelectedState(this.categoryColor);

  @override
  List<Object> get props => [categoryColor, identityHashCode(this)];
}
