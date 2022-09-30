part of 'accounts_bloc.dart';

@immutable
abstract class AccountsEvent extends Equatable {
  const AccountsEvent();
  @override
  List<Object> get props => [];
}

class FetchAccountsEvent extends AccountsEvent {}

class AddAccountEvent extends AccountsEvent {}

class UpdateAccountEvent extends AccountsEvent {}

class DeleteAccountEvent extends AccountsEvent {
  final Account account;

  const DeleteAccountEvent(this.account);
}

class AccountSelectedEvent extends AccountsEvent {
  final Account account;

  const AccountSelectedEvent(this.account);
}

class FetchAccountFromIdEvent extends AccountsEvent {
  final String? accountId;

  const FetchAccountFromIdEvent(this.accountId);
}

class ClearAccountEvent extends AccountsEvent {
  final String accountId;

  const ClearAccountEvent(this.accountId);
}
