part of 'accounts_bloc.dart';

@immutable
abstract class AccountsEvent extends Equatable {
  const AccountsEvent();
  @override
  List<Object> get props => [];
}

class AddOrUpdateAccountEvent extends AccountsEvent {
  final bool isAdding;

  const AddOrUpdateAccountEvent(this.isAdding);
}

class DeleteAccountEvent extends AccountsEvent {
  final int accountId;

  const DeleteAccountEvent(this.accountId);
  @override
  List<Object> get props => [accountId];
}

class AccountSelectedEvent extends AccountsEvent {
  final Account account;

  const AccountSelectedEvent(this.account);
  @override
  List<Object> get props => [account];
}

class FetchAccountFromIdEvent extends AccountsEvent {
  final String? accountId;

  const FetchAccountFromIdEvent(this.accountId);

  @override
  List<Object> get props => [accountId ?? ''];
}

class UpdateCardTypeEvent extends AccountsEvent {
  final CardType cardType;

  const UpdateCardTypeEvent(this.cardType);

  @override
  List<Object> get props => [cardType];
}
