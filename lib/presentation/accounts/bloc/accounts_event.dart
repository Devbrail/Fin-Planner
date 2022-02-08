part of 'accounts_bloc.dart';

@immutable
abstract class AccountsEvent {}

class FetchAccountsEvent extends AccountsEvent {}

class AddAccountEvent extends AccountsEvent {
  final String holderName;
  final String bankName;
  final String number;
  final DateTime validThru;
  final int icon;
  final CardType cardType;

  AddAccountEvent({
    required this.bankName,
    required this.holderName,
    required this.number,
    required this.icon,
    required this.validThru,
    required this.cardType,
  });
}

class UpdateAccountEvent extends AccountsEvent {
  final Account account;

  UpdateAccountEvent(this.account);
}

class DeleteAccountEvent extends AccountsEvent {
  final Account account;

  DeleteAccountEvent(this.account);
}

class AccountSeletedEvent extends AccountsEvent {
  final Account account;

  AccountSeletedEvent(this.account);
}
