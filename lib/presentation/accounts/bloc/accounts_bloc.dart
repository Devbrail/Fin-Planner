import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../common/enum/card_type.dart';
import '../../../data/accounts/model/account.dart';
import '../../../domain/account/usecase/account_use_case.dart';
import '../../../domain/landing/usecase/expense_use_case.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required this.accountUseCase,
    required this.expenseUseCase,
  }) : super(AccountsInitial()) {
    on<AccountsEvent>((event, emit) {});
    on<FetchAccountsEvent>((event, emit) => _fetchAccount(emit));
    on<AddAccountEvent>((event, emit) => _addAccount(event, emit));
    on<DeleteAccountEvent>((event, emit) => _deleteAccount(event, emit));
    on<AccountSeletedEvent>((event, emit) => _accountSelected(event, emit));
    on<UpdateAccountEvent>((event, emit) => _update(event, emit));
  }
  final AccountUseCase accountUseCase;
  final ExpenseUseCase expenseUseCase;

  _fetchAccount(Emitter<AccountsState> emit) async {
    final accounts = await accountUseCase.accounts();
    emit(AccountListState(accounts));
  }

  _addAccount(AddAccountEvent event, Emitter<AccountsState> emit) async {
    await accountUseCase.addAccount(
        bankName: event.bankName,
        icon: event.icon,
        holderName: event.holderName,
        number: event.number,
        validThru: event.validThru,
        cardType: event.cardType);
    emit(AddAccountState());
    add(FetchAccountsEvent());
  }

  _deleteAccount(DeleteAccountEvent event, Emitter<AccountsState> emit) async {
    await accountUseCase.deleteAccount(event.account.key);
    emit(AccountDeletedState());
  }

  _accountSelected(AccountSeletedEvent event, Emitter<AccountsState> emit) {
    emit(AccountSeletedState(event.account));
  }

  _update(UpdateAccountEvent event, Emitter<AccountsState> emit) async {
    await accountUseCase.updateAccount(event.account);
    emit(AddAccountState());
  }
}
