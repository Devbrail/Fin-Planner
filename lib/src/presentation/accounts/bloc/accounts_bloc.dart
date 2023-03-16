import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart' show immutable;
import 'package:paisa/src/data/category/model/category_model.dart';
import 'package:paisa/src/data/expense/model/expense_model.dart';
import 'package:paisa/src/domain/account/entities/account.dart';
import 'package:paisa/src/domain/category/use_case/category_use_case.dart';
import 'package:paisa/src/domain/expense/entities/expense.dart';
import 'package:paisa/src/domain/expense/use_case/expense_use_case.dart';
import 'package:paisa/src/domain/expense/use_case/get_expense_from_account_id.dart';

import '../../../core/enum/card_type.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/account/use_case/account_use_case.dart';

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
  }) : super(AccountsInitial()) {
    on<AccountsEvent>((event, emit) {});
    on<AddOrUpdateAccountEvent>(_addAccount);
    on<DeleteAccountEvent>(_deleteAccount);
    on<AccountSelectedEvent>(_accountSelected);
    on<ClearAccountEvent>(_clearAccount);
    on<UpdateCardTypeEvent>(_updateCardType);
    on<FetchAccountFromIdEvent>(_fetchAccountFromId);
  }

  final GetExpensesFromAccountIdUseCase getExpensesFromAccountIdUseCase;
  final DeleteExpensesFromAccountIdUseCase deleteExpensesFromAccountIdUseCase;
  final GetAccountUseCase getAccountUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final AddAccountUseCase addAccountUseCase;
  final GetAccountsUseCase getAccountsUseCase;
  final GetCategoryUseCase getCategoryUseCase;

  CardType selectedType = CardType.cash;
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

    final Account? account = getAccountUseCase(accountId);
    if (account != null) {
      accountName = account.bankName;
      accountHolderName = account.name;
      accountNumber = account.number;
      selectedType = account.cardType ?? CardType.cash;
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
      await addAccountUseCase(
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
    await deleteAccountUseCase(event.account.superId!);
    await deleteExpensesFromAccountIdUseCase(event.account.superId!);
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
    await deleteAccountUseCase(expenseId);
    emit(AccountDeletedState());
  }

  FutureOr<void> _updateCardType(
    UpdateCardTypeEvent event,
    Emitter<AccountsState> emit,
  ) async {
    selectedType = event.cardType;
    emit(UpdateCardTypeState(event.cardType));
  }

  CategoryModel? fetchCategoryFromId(int categoryId) =>
      getCategoryUseCase(categoryId);

  List<Expense> fetchExpenseFromAccountId(int accountId) =>
      getExpensesFromAccountIdUseCase(accountId);
}
