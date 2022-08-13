import 'package:bloc/bloc.dart' show Bloc, Emitter;
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

import '../../../common/enum/box_types.dart';
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
  late final box = Hive.box<Account>(BoxType.accounts.stringValue);

  _fetchAccount(Emitter<AccountsState> emit) async {
    final accounts = await accountUseCase.accounts();
    emit(AccountListState(accounts));
  }

  _addAccount(AddAccountEvent event, Emitter<AccountsState> emit) async {
    final account = Account(
      bankName: event.bankName,
      icon: event.icon,
      name: event.holderName,
      number: event.number,
      validThru: event.validThru,
      cardType: event.cardType,
    );

    final int id = await box.add(account);
    account.superId = id;
    await account.save();

    emit(AddAccountState());
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
