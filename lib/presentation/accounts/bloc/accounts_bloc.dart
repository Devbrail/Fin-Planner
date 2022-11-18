import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

import '../../../common/enum/box_types.dart';
import '../../../common/enum/card_type.dart';
import '../../../data/accounts/model/account.dart';
import '../../../domain/account/use_case/account_use_case.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required this.accountUseCase,
  }) : super(AccountsInitial()) {
    on<AccountsEvent>((event, emit) {});
    on<FetchAccountsEvent>((event, emit) => _fetchAccounts(emit));
    on<AddOrUpdateAccountEvent>(_addAccount);
    on<DeleteAccountEvent>(_deleteAccount);
    on<AccountSelectedEvent>(_accountSelected);
    on<ClearAccountEvent>(_clearAccount);
    on<UpdateCardTypeEvent>(_updateCardType);
    on<FetchAccountFromIdEvent>(_fetchAccountFromId);
  }
  final AccountUseCase accountUseCase;
  late final box = Hive.box<Account>(BoxType.accounts.stringValue);

  late CardType selectedType = CardType.bank;
  String? accountName;
  String? accountHolderName;
  String? accountNumber;
  Account? currentAccount;

  Future<void> _fetchAccounts(Emitter<AccountsState> emit) async {
    final accounts = await accountUseCase.accounts();
    emit(AccountListState(accounts));
  }

  Future<void> _fetchAccountFromId(
    FetchAccountFromIdEvent event,
    Emitter<AccountsState> emit,
  ) async {
    final int? accountId = int.tryParse(event.accountId ?? '');
    if (accountId == null) return;

    final Account? account = await accountUseCase.fetchAccountFromId(accountId);
    if (account != null) {
      emit(AccountSuccessState(account));
      accountName = account.bankName;
      accountHolderName = account.name;
      accountNumber = account.number;
      selectedType = account.cardType ?? CardType.bank;
      currentAccount = account;
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

    if (bankName == null) {
      return emit(const AccountErrorState('Set bank name'));
    }
    if (holderName == null) {
      return emit(const AccountErrorState('Set account holder name'));
    }

    if (event.isAdding) {
      await accountUseCase.addAccount(
        bankName: bankName,
        holderName: holderName,
        number: number ?? '',
        cardType: cardType,
      );
    } else {
      if (currentAccount != null) {
        currentAccount!
          ..bankName = bankName
          ..cardType = cardType
          ..icon = cardType.icon.codePoint
          ..name = holderName
          ..number = number ?? ''
          ..cardType = cardType;

        await currentAccount!.save();
      }
    }
    emit(AddAccountState(isAddOrUpdate: event.isAdding));
  }

  _deleteAccount(DeleteAccountEvent event, Emitter<AccountsState> emit) async {
    await accountUseCase.deleteAccount(event.account.key);
    emit(AccountDeletedState());
  }

  _accountSelected(AccountSelectedEvent event, Emitter<AccountsState> emit) {
    emit(AccountSelectedState(event.account));
  }

  _clearAccount(
    ClearAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    final int? expenseId = int.tryParse(event.accountId);
    if (expenseId == null) return;
    await accountUseCase.deleteAccount(expenseId);
    emit(AccountDeletedState());
  }

  _updateCardType(UpdateCardTypeEvent event, Emitter<AccountsState> emit) =>
      emit(UpdateCardTypeState(event.cardType));
}
