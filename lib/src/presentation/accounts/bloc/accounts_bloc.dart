import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/enum/card_type.dart';
import '../../../data/accounts/model/account.dart';
import '../../../domain/account/use_case/account_use_case.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required this.accountUseCase,
    required this.deleteAccountUseCase,
    required this.addAccountUseCase,
  }) : super(AccountsInitial()) {
    on<AccountsEvent>((event, emit) {});
    on<AddOrUpdateAccountEvent>(_addAccount);
    on<DeleteAccountEvent>(_deleteAccount);
    on<AccountSelectedEvent>(_accountSelected);
    on<ClearAccountEvent>(_clearAccount);
    on<UpdateCardTypeEvent>(_updateCardType);
    on<FetchAccountFromIdEvent>(_fetchAccountFromId);
  }

  final GetAccountUseCase accountUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final AddAccountUseCase addAccountUseCase;

  late CardType selectedType = CardType.bank;
  String? accountName;
  String? accountHolderName;
  String? accountNumber;
  Account? currentAccount;
  double? initialAmount;

  Future<void> _fetchAccountFromId(
    FetchAccountFromIdEvent event,
    Emitter<AccountsState> emit,
  ) async {
    final int? accountId = int.tryParse(event.accountId ?? '');
    if (accountId == null) return;

    final Account? account = await accountUseCase.execute(accountId);
    if (account != null) {
      accountName = account.bankName;
      accountHolderName = account.name;
      accountNumber = account.number;
      selectedType = account.cardType ?? CardType.bank;
      initialAmount = account.amount;
      currentAccount = account;
      emit(AccountSuccessState(account));
    } else {
      emit(const AccountErrorState('Account not found!'));
    }
  }

  Future<void> _addAccount(
    AddOrUpdateAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    final String? bankName = accountName;
    final String? holderName = accountHolderName;
    final String? number = accountNumber;
    final CardType cardType = selectedType;
    final double? amount = initialAmount;

    if (bankName == null) {
      return emit(const AccountErrorState('Set bank name'));
    }
    if (holderName == null) {
      return emit(const AccountErrorState('Set account holder name'));
    }

    if (event.isAdding) {
      await addAccountUseCase.execute(
        bankName: bankName,
        holderName: holderName,
        number: number ?? '',
        cardType: cardType,
        amount: amount ?? 0,
      );
    } else {
      if (currentAccount != null) {
        currentAccount!
          ..bankName = bankName
          ..cardType = cardType
          ..icon = cardType.icon.codePoint
          ..name = holderName
          ..number = number ?? ''
          ..amount = amount;

        await currentAccount!.save();
      }
    }
    emit(AddAccountState(isAddOrUpdate: event.isAdding));
  }

  FutureOr<void> _deleteAccount(
    DeleteAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    await deleteAccountUseCase.execute(event.account.key);
    emit(AccountDeletedState());
  }

  FutureOr<void> _accountSelected(
    AccountSelectedEvent event,
    Emitter<AccountsState> emit,
  ) async =>
      emit(AccountSelectedState(event.account));

  FutureOr<void> _clearAccount(
    ClearAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    final int? expenseId = int.tryParse(event.accountId);
    if (expenseId == null) return;
    await deleteAccountUseCase.execute(expenseId);
    emit(AccountDeletedState());
  }

  FutureOr<void> _updateCardType(
    UpdateCardTypeEvent event,
    Emitter<AccountsState> emit,
  ) async =>
      emit(UpdateCardTypeState(event.cardType));
}
