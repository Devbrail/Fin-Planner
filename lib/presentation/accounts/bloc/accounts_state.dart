part of 'accounts_bloc.dart';

@immutable
abstract class AccountsState {}

class AccountsInitial extends AccountsState {}

class AccountListState extends AccountsState {
  final List<Account> accounts;

  AccountListState(this.accounts);
}

class AddAccountState extends AccountsState {}

class AccountDeletedState extends AccountsState {}

class AccountSeletedState extends AccountsState {
  final Account account;

  AccountSeletedState(this.account);
}
