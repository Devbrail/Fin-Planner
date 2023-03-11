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

class AddAccountState extends AccountsState {
  final bool isAddOrUpdate;

  const AddAccountState({this.isAddOrUpdate = false});
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
