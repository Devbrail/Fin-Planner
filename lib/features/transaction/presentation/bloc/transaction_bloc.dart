import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/enum/recurring_type.dart';
import 'package:paisa/core/enum/transaction_type.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/account/domain/use_case/account_use_case.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/category/domain/use_case/category_use_case.dart';
import 'package:paisa/features/settings/domain/use_case/settings_use_case.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/use_case/transaction_use_case.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<ExpenseEvent, TransactionState> {
  TransactionBloc(
    this.settingsUseCase, {
    required this.getTransactionUseCase,
    required this.accountUseCase,
    required this.addTransactionUseCase,
    required this.deleteTransactionUseCase,
    required this.updateTransactionUseCase,
    required this.accountsUseCase,
    required this.getDefaultCategoriesUseCase,
  }) : super(ExpenseInitial()) {
    on<ExpenseEvent>((event, emit) {});
    on<AddOrUpdateExpenseEvent>(_addExpense);
    on<ClearExpenseEvent>(_deleteExpense);
    on<ChangeTransactionTypeEvent>(_changeExpense);
    on<FindTransactionFromIdEvent>(_fetchExpenseFromId);
    on<ChangeCategoryEvent>(_changeCategory);
    on<ChangeAccountEvent>(_changeAccount);
    on<UpdateDateTimeEvent>(_updateDateTime);
    on<TransferAccountEvent>(_transferAccount);
    on<FetchDefaultCategoryEvent>(_fetchDefaultCategories);
  }

  final GetAccountUseCase accountUseCase;
  final GetAccountsUseCase accountsUseCase;
  final AddTransactionUseCase addTransactionUseCase;
  String? currentDescription;
  TransactionEntity? currentExpense;
  final GetDefaultCategoriesUseCase getDefaultCategoriesUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;
  double? transactionAmount;
  String? expenseName;
  final GetTransactionUseCase getTransactionUseCase;
  RecurringType recurringType = RecurringType.daily;
  int? selectedAccountId;
  int? selectedCategoryId;
  DateTime selectedDate = DateTime.now();
  final SettingsUseCase settingsUseCase;
  TimeOfDay timeOfDay = TimeOfDay.now();
  AccountEntity? fromAccount, toAccount;
  TransactionType transactionType = TransactionType.expense;

  final UpdateTransactionUseCase updateTransactionUseCase;

  Future<void> _fetchExpenseFromId(
    FindTransactionFromIdEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final int? expenseId = int.tryParse(event.expenseId ?? '');
    if (expenseId == null) {
      selectedAccountId = settingsUseCase.get(defaultAccountIdKey);
      return;
    }

    final TransactionEntity? transaction =
        await getTransactionUseCase(GetTransactionParams(expenseId));
    if (transaction != null) {
      transactionAmount = transaction.currency;
      expenseName = transaction.name;
      selectedCategoryId = transaction.categoryId;
      selectedAccountId = transaction.accountId;
      selectedDate = transaction.time ?? DateTime.now();
      if (transaction.time == null) {
        timeOfDay = TimeOfDay.now();
      } else {
        timeOfDay = TimeOfDay.fromDateTime(transaction.time!);
      }
      transactionType = transaction.type ?? TransactionType.expense;
      currentDescription = transaction.description;
      currentExpense = transaction;
      emit(TransactionFoundState(transaction));
      Future.delayed(Duration.zero)
          .then((value) => add(ChangeTransactionTypeEvent(transactionType)));
    } else {
      emit(const TransactionErrorState('Expense not found!'));
    }
  }

  Future<void> _addExpense(
    AddOrUpdateExpenseEvent event,
    Emitter<TransactionState> emit,
  ) async {
    if (transactionType == TransactionType.transfer) {
      if ((fromAccount == null || toAccount == null) ||
          (fromAccount == toAccount)) {
        return emit(
          const TransactionErrorState('Select both from and to accounts'),
        );
      }
      final double? validAmount = transactionAmount;
      final int? categoryId = selectedCategoryId;
      if (validAmount == null || validAmount == 0.0) {
        return emit(const TransactionErrorState('Enter valid amount'));
      }
      if (categoryId == null) {
        return emit(const TransactionErrorState('Select category'));
      }
      await addTransactionUseCase(AddTransactionParams(
        name:
            'Transfer from ${fromAccount!.bankName} to ${toAccount!.bankName}',
        amount: validAmount,
        time: selectedDate,
        categoryId: categoryId,
        accountId: fromAccount!.superId!,
        transactionType: TransactionType.expense,
        description: '',
      ));

      await addTransactionUseCase(AddTransactionParams(
        name:
            'Received from ${fromAccount?.bankName} to ${toAccount?.bankName}',
        amount: validAmount,
        time: selectedDate,
        categoryId: categoryId,
        accountId: toAccount!.superId!,
        transactionType: TransactionType.income,
        description: '',
      ));

      emit(const TransactionAdded(isAddOrUpdate: true));
    } else {
      final double? validAmount = transactionAmount;
      final String? name = expenseName;
      final int? categoryId = selectedCategoryId;
      final int? accountId = selectedAccountId;
      final DateTime dateTime = selectedDate;
      final String? description = currentDescription;

      if (name == null) {
        return emit(const TransactionErrorState('Enter expense name'));
      }
      if (validAmount == null || validAmount == 0.0) {
        return emit(const TransactionErrorState('Enter valid amount'));
      }

      if (accountId == null || accountId == -1) {
        return emit(const TransactionErrorState('Select account'));
      }
      if (categoryId == null) {
        return emit(const TransactionErrorState('Select category'));
      }

      if (event.isAdding) {
        await addTransactionUseCase(AddTransactionParams(
          name: name,
          amount: validAmount,
          time: dateTime,
          categoryId: categoryId,
          accountId: accountId,
          transactionType: transactionType,
          description: description,
        ));
      } else {
        if (currentExpense == null) return;
        await updateTransactionUseCase(UpdateTransactionParams(
          currentExpense!.superId!,
          accountId: accountId,
          categoryId: categoryId,
          currency: validAmount,
          description: description,
          name: name,
          time: dateTime,
          type: transactionType,
        ));
      }
      emit(TransactionAdded(isAddOrUpdate: event.isAdding));
    }
  }

  Future<void> _deleteExpense(
    ClearExpenseEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final int transactionId = int.parse(event.expenseId);
    await deleteTransactionUseCase(
      DeleteTransactionParams(transactionId),
    );
    emit(TransactionDeletedState());
  }

  void _changeExpense(
    ChangeTransactionTypeEvent event,
    Emitter<TransactionState> emit,
  ) {
    final List<AccountEntity> accounts = accountsUseCase(NoParams());
    if (accounts.isEmpty &&
        accounts.length <= 1 &&
        event.transactionType == TransactionType.transfer) {
      emit(const TransactionErrorState('Need two or more accounts '));
    } else {
      transactionType = event.transactionType;
      emit(ChangeTransactionTypeState(event.transactionType));
    }
  }

  FutureOr<void> _changeCategory(
    ChangeCategoryEvent event,
    Emitter<TransactionState> emit,
  ) {
    selectedCategoryId = event.category.superId;
    emit(ChangeCategoryState(event.category));
  }

  FutureOr<void> _changeAccount(
    ChangeAccountEvent event,
    Emitter<TransactionState> emit,
  ) {
    selectedAccountId = event.account.superId;
    emit(ChangeAccountState(event.account));
  }

  FutureOr<void> _updateDateTime(
    UpdateDateTimeEvent event,
    Emitter<TransactionState> emit,
  ) {
    selectedDate = event.dateTime;
    emit(UpdateDateTimeState(event.dateTime));
  }

  FutureOr<void> _transferAccount(
    TransferAccountEvent event,
    Emitter<TransactionState> emit,
  ) {
    if (event.isFromAccount) {
      fromAccount = event.account;
    } else {
      toAccount = event.account;
    }
    emit(TransferAccountState(
      event.isFromAccount,
      fromAccount,
      toAccount,
    ));
  }

  FutureOr<void> _fetchDefaultCategories(
    FetchDefaultCategoryEvent event,
    Emitter<TransactionState> emit,
  ) {
    final List<CategoryEntity> categories =
        getDefaultCategoriesUseCase(NoParams());
    emit(DefaultCategoriesState(categories));
  }
}
