import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enum/card_type.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/account/use_case/account_use_case.dart';
import '../../../domain/category/use_case/category_use_case.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

@injectable
class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required this.getAccountUseCase,
    required this.deleteAccountUseCase,
    required this.getExpensesFromAccountIdUseCase,
    required this.addAccountUseCase,
    required this.getAccountsUseCase,
    required this.getCategoryUseCase,
    required this.deleteExpensesFromAccountIdUseCase,
    required this.updateAccountUseCase,
  }) : super(AccountsInitial()) {
    on<AccountsEvent>((event, emit) {});
    on<AddOrUpdateAccountEvent>(_addAccount);
    on<DeleteAccountEvent>(_deleteAccount);
    on<AccountSelectedEvent>(_accountSelected);
    on<UpdateCardTypeEvent>(_updateCardType);
    on<FetchAccountFromIdEvent>(_fetchAccountFromId);
    on<FetchExpensesFromAccountIdEvent>(_fetchExpensesFromAccountId);
    on<AccountColorSelectedEvent>(_updateAccountColor);
    on<FetchAccountAndExpenseFromIdEvent>(_fetchAccountAndExpensesFromId);
  }

  String? accountHolderName;
  String? accountName;
  String? accountNumber;
  final AddAccountUseCase addAccountUseCase;
  Account? currentAccount;
  final DeleteAccountUseCase deleteAccountUseCase;
  final DeleteExpensesFromAccountIdUseCase deleteExpensesFromAccountIdUseCase;
  final GetAccountUseCase getAccountUseCase;
  final GetAccountsUseCase getAccountsUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final GetExpensesFromAccountIdUseCase getExpensesFromAccountIdUseCase;
  double? initialAmount;
  int? selectedColor;
  CardType selectedType = CardType.cash;
  final UpdateAccountUseCase updateAccountUseCase;

  Future<void> _fetchAccountFromId(
    FetchAccountFromIdEvent event,
    Emitter<AccountsState> emit,
  ) async {
    final int? accountId = int.tryParse(event.accountId ?? '');
    if (accountId == null) return;

    final Account? account = getAccountUseCase(accountId);
    if (account != null) {
      accountName = account.bankName;
      accountHolderName = account.name;
      accountNumber = account.number;
      selectedType = account.cardType ?? CardType.cash;
      initialAmount = account.amount;
      currentAccount = account;
      selectedColor = account.color ?? Colors.brown.shade100.value;
      emit(AccountSuccessState(account));
      emit(UpdateCardTypeState(selectedType));
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
    final int? color = selectedColor;
    if (bankName == null) {
      return emit(const AccountErrorState('Set bank name'));
    }
    if (holderName == null) {
      return emit(const AccountErrorState('Set account holder name'));
    }
    if (color == null) {
      return emit(const AccountErrorState('Set account color name'));
    }

    if (event.isAdding) {
      await addAccountUseCase(
        bankName: bankName,
        holderName: holderName,
        number: number ?? '',
        cardType: cardType,
        amount: amount ?? 0,
        color: color,
      );
    } else {
      if (currentAccount == null) return;
      currentAccount!
        ..bankName = bankName
        ..cardType = cardType
        ..name = holderName
        ..number = number ?? ''
        ..amount = amount
        ..color = color;

      await updateAccountUseCase(account: currentAccount!);
    }
    emit(AccountAddedState(isAddOrUpdate: event.isAdding));
  }

  FutureOr<void> _deleteAccount(
    DeleteAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    await deleteExpensesFromAccountIdUseCase(int.parse(event.accountId));
    await deleteAccountUseCase(int.parse(event.accountId));
    emit(AccountDeletedState());
  }

  FutureOr<void> _accountSelected(
    AccountSelectedEvent event,
    Emitter<AccountsState> emit,
  ) async {
    final List<Expense> expenses =
        getExpensesFromAccountIdUseCase(event.account.superId!);
    emit(AccountSelectedState(event.account, expenses));
  }

  FutureOr<void> _updateCardType(
    UpdateCardTypeEvent event,
    Emitter<AccountsState> emit,
  ) async {
    selectedType = event.cardType;
    emit(UpdateCardTypeState(event.cardType));
  }

  FutureOr<void> _fetchExpensesFromAccountId(
    FetchExpensesFromAccountIdEvent event,
    Emitter<AccountsState> emit,
  ) async {
    List<Expense> expenses =
        getExpensesFromAccountIdUseCase(int.parse(event.accountId));
    emit(ExpensesFromAccountIdState(expenses));
  }

  FutureOr<void> _updateAccountColor(
    AccountColorSelectedEvent event,
    Emitter<AccountsState> emit,
  ) {
    selectedColor = event.accountColor;
    emit(AccountColorSelectedState(event.accountColor));
  }

  FutureOr<void> _fetchAccountAndExpensesFromId(
    FetchAccountAndExpenseFromIdEvent event,
    Emitter<AccountsState> emit,
  ) async {
    final int? accountId = int.tryParse(event.accountId);
    if (accountId == null) {
      return;
    }

    final Account? account = getAccountUseCase(accountId);
    final List<Expense> expenses = getExpensesFromAccountIdUseCase(accountId);
    if (account != null) {
      emit(AccountAndExpensesState(account, expenses));
    }
  }
}
