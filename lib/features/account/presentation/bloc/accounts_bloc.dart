import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/core/enum/card_type.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/account/domain/use_case/account_use_case.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/category/domain/use_case/get_categories_use_case.dart';
import 'package:paisa/features/category/domain/use_case/get_category_use_case.dart';
import 'package:paisa/features/home/domain/entity/combined_request.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';
import 'package:paisa/features/home/presentation/cubit/combined_transaction/combined_transaction_cubit.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/use_case/transaction_use_case.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

@injectable
class AccountBloc extends Bloc<AccountsEvent, AccountState> {
  AccountBloc(
    this.getCategoriesUseCase,
    this.getAccountUseCase,
    this.deleteAccountUseCase,
    this.getTransactionsByAccountIdUseCase,
    this.addAccountUseCase,
    this.getCategoryUseCase,
    this.deleteExpensesFromAccountIdUseCase,
    this.updateAccountUseCase,
  ) : super(AccountsInitial()) {
    on<AccountsEvent>((AccountsEvent event, Emitter<AccountState> emit) {});
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
  AccountEntity? currentAccount;
  final DeleteAccountUseCase deleteAccountUseCase;
  final DeleteTransactionsByAccountIdUseCase deleteExpensesFromAccountIdUseCase;
  final GetAccountUseCase getAccountUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetTransactionsByAccountIdUseCase getTransactionsByAccountIdUseCase;
  double? initialAmount;
  int? selectedColor;
  CardType selectedType = CardType.cash;
  final UpdateAccountUseCase updateAccountUseCase;

  Future<void> _fetchAccountFromId(
    FetchAccountFromIdEvent event,
    Emitter<AccountState> emit,
  ) async {
    final int? accountId = int.tryParse(event.accountId ?? '');
    if (accountId == null) return;

    final AccountEntity? account =
        getAccountUseCase(params: GetAccountParams(accountId));
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
    Emitter<AccountState> emit,
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
          params: AddAccountParams(
        bankName: bankName,
        holderName: holderName,
        number: number ?? '',
        cardType: cardType,
        amount: amount ?? 0,
        color: color,
      ));
    } else {
      if (currentAccount == null) return;
      await updateAccountUseCase(
          params: UpdateAccountParams(
        currentAccount!.superId!,
        bankName: bankName,
        holderName: holderName,
        number: number ?? '',
        cardType: cardType,
        amount: amount ?? 0,
        color: color,
      ));
    }
    emit(AccountAddedState(isAddOrUpdate: event.isAdding));
  }

  FutureOr<void> _deleteAccount(
    DeleteAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    final int accountId = int.parse(event.accountId);
    await deleteExpensesFromAccountIdUseCase(
      params: DeleteTransactionsFromAccountIdParams(accountId),
    );
    await deleteAccountUseCase(params: DeleteAccountParams(accountId));
    emit(AccountDeletedState());
  }

  FutureOr<void> _accountSelected(
    AccountSelectedEvent event,
    Emitter<AccountState> emit,
  ) async {
    final List<TransactionEntity> transactions =
        getTransactionsByAccountIdUseCase(
      params: GetTransactionsByAccountIdParams(event.account.superId!),
    );
    final List<AccountEntity> accounts = [event.account];
    final List<CategoryEntity> categories = getCategoriesUseCase();
    final List<CombinedTransactionEntity> result = await compute(
      combineList,
      CombineRequest(
        accounts,
        categories,
        transactions,
      ),
    );
    emit(AccountSelectedState(event.account, result));
  }

  FutureOr<void> _updateCardType(
    UpdateCardTypeEvent event,
    Emitter<AccountState> emit,
  ) async {
    selectedType = event.cardType;
    emit(UpdateCardTypeState(event.cardType));
  }

  FutureOr<void> _fetchExpensesFromAccountId(
    FetchExpensesFromAccountIdEvent event,
    Emitter<AccountState> emit,
  ) async {
    List<TransactionEntity> expenses = getTransactionsByAccountIdUseCase(
      params: GetTransactionsByAccountIdParams(int.parse(event.accountId)),
    );
    emit(ExpensesFromAccountIdState(expenses));
  }

  FutureOr<void> _updateAccountColor(
    AccountColorSelectedEvent event,
    Emitter<AccountState> emit,
  ) {
    selectedColor = event.accountColor;
    emit(AccountColorSelectedState(event.accountColor));
  }

  FutureOr<void> _fetchAccountAndExpensesFromId(
    FetchAccountAndExpenseFromIdEvent event,
    Emitter<AccountState> emit,
  ) async {
    final int? accountId = int.tryParse(event.accountId);
    if (accountId == null) {
      return;
    }
    final AccountEntity? account = getAccountUseCase(
      params: GetAccountParams(accountId),
    );

    if (account != null) {
      final List<TransactionEntity> transactions =
          getTransactionsByAccountIdUseCase(
        params: GetTransactionsByAccountIdParams(accountId),
      );
      final List<AccountEntity> accounts = [account];
      final List<CategoryEntity> categories = getCategoriesUseCase();
      final List<CombinedTransactionEntity> result = await compute(
        combineList,
        CombineRequest(
          accounts,
          categories,
          transactions,
        ),
      );
      emit(AccountAndCombinedTransactionsState(account, result));
    }
  }
}
