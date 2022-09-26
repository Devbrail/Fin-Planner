part of 'accounts_bloc.dart';

@immutable
abstract class AccountsEvent extends Equatable {
  const AccountsEvent();
  @override
  List<Object> get props => [];
}

class FetchAccountsEvent extends AccountsEvent {}

class AddAccountEvent extends AccountsEvent {
  final String? holderName;
  final String? bankName;
  final String? number;
  final DateTime validThru;
  final int icon;
  final CardType cardType;

  const AddAccountEvent({
    required this.bankName,
    required this.holderName,
    required this.number,
    required this.icon,
    required this.validThru,
    required this.cardType,
  });
}

class UpdateAccountEvent extends AccountsEvent {
  final Account? account;
  final String? holderName;
  final String? bankName;
  final String? number;
  final DateTime validThru;
  final int icon;
  final CardType cardType;

  const UpdateAccountEvent({
    required this.account,
    required this.bankName,
    required this.holderName,
    required this.number,
    required this.icon,
    required this.validThru,
    required this.cardType,
  });
}

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
