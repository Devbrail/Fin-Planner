import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/presentation/settings/bloc/settings_controller.dart';

import '../../../core/enum/transaction.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../data/category/model/category_model.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/account/use_case/account_use_case.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';
import '../../../domain/expense/use_case/update_expense_use_case.dart';

part 'expense_event.dart';
part 'expense_state.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc(
    this.settingsController, {
    required this.expenseUseCase,
    required this.accountUseCase,
    required this.addExpenseUseCase,
    required this.deleteExpenseUseCase,
    required this.updateExpensesUseCase,
    required this.accountsUseCase,
  }) : super(ExpenseInitial()) {
    on<ExpenseEvent>((event, emit) {});
    on<AddOrUpdateExpenseEvent>(_addExpense);
    on<ClearExpenseEvent>(_deleteExpense);
    on<ChangeExpenseEvent>(_changeExpense);
    on<FetchExpenseFromIdEvent>(_fetchExpenseFromId);
    on<ChangeCategoryEvent>(_changeCategory);
    on<ChangeAccountEvent>(_changeAccount);
    on<UpdateDateTimeEvent>(_updateDateTime);
    on<TransferAccountsEvent>(_transferAccount);
  }

  final GetExpenseUseCase expenseUseCase;
  final AddExpenseUseCase addExpenseUseCase;
  final GetAccountUseCase accountUseCase;
  final GetAccountsUseCase accountsUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;
  final UpdateExpensesUseCase updateExpensesUseCase;
  final SettingsController settingsController;

  String? expenseName;
  double? expenseAmount;
  double? transferAmount;
  int? selectedCategoryId;
  int? selectedAccountId;
  Expense? currentExpense;
  String? currentDescription;
  DateTime selectedDate = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  TransactionType transactionType = TransactionType.expense;
  Account? fromAccount, toAccount;

  Future<void> _fetchExpenseFromId(
    FetchExpenseFromIdEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final int? expenseId = int.tryParse(event.expenseId ?? '');
    if (expenseId == null) return;

    final Expense? expense = await expenseUseCase(expenseId);
    if (expense != null) {
      expenseAmount = expense.currency;
      expenseName = expense.name;
      selectedCategoryId = expense.categoryId;
      if (settingsController.defaultAccountId == null ||
          settingsController.defaultAccountId == -1) {
        selectedAccountId = expense.accountId;
      } else {
        selectedAccountId = settingsController.defaultAccountId;
      }

      selectedDate = expense.time;
      timeOfDay = TimeOfDay.fromDateTime(expense.time);
      transactionType = expense.type ?? TransactionType.expense;
      currentDescription = expense.description;
      currentExpense = expense;
      emit(ExpenseSuccessState(expense));
      Future.delayed(Duration.zero)
          .then((value) => add(ChangeExpenseEvent(transactionType)));
    } else {
      emit(const ExpenseErrorState('Expense not found!'));
    }
  }

  Future<void> _addExpense(
    AddOrUpdateExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    if (transactionType == TransactionType.transfer) {
      if ((fromAccount == null || toAccount == null) ||
          (fromAccount == toAccount)) {
        return emit(
          const ExpenseErrorState(
            'Select both from and to accounts',
          ),
        );
      }
      final String expenseName =
          'Transfer from ${fromAccount?.bankName} to ${toAccount?.bankName}';
      await addExpenseUseCase(
        name: expenseName,
        amount: transferAmount ?? 0,
        time: DateTime.now(),
        categoryId: -1,
        accountId: -1,
        transactionType: TransactionType.transfer,
        description: 'Transfer money',
        fromAccountId: fromAccount?.superId,
        toAccountId: toAccount?.superId,
        transferAmount: transferAmount ?? 0,
      );

      emit(const ExpenseAdded(isAddOrUpdate: true));
    } else {
      final double? validAmount = expenseAmount;
      final String? name = expenseName;
      final int? categoryId = selectedCategoryId;
      final int? accountId = selectedAccountId;
      final DateTime dateTime = selectedDate;
      final String? description = currentDescription;

      if (name == null) {
        return emit(const ExpenseErrorState('Enter expense name'));
      }
      if (validAmount == null || validAmount == 0.0) {
        return emit(const ExpenseErrorState('Enter valid amount'));
      }

      if (accountId == null) {
        return emit(const ExpenseErrorState('Select account'));
      }
      if (categoryId == null) {
        return emit(const ExpenseErrorState('Select category'));
      }

      if (event.isAdding) {
        await addExpenseUseCase(
          name: name,
          amount: validAmount,
          time: dateTime,
          categoryId: categoryId,
          accountId: accountId,
          transactionType: transactionType,
          description: description,
        );
      } else {
        if (currentExpense == null) return;
        currentExpense!
          ..accountId = accountId
          ..categoryId = categoryId
          ..currency = validAmount
          ..name = name
          ..time = dateTime
          ..type = transactionType
          ..description = description;
        await updateExpensesUseCase(currentExpense!);
      }
      emit(ExpenseAdded(isAddOrUpdate: event.isAdding));
    }
  }

  Future<void> _deleteExpense(
    ClearExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    await deleteExpenseUseCase(int.parse(event.expenseId));
    emit(ExpenseDeletedState());
  }

  void _changeExpense(
    ChangeExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) {
    final List<Account> accounts = accountsUseCase();
    if (accounts.length == 1 &&
        event.transactionType == TransactionType.transfer) {
      emit(const ExpenseErrorState('Need two or more accounts '));
    } else {
      transactionType = event.transactionType;
      emit(ChangeTransactionTypeState(event.transactionType));
      if (event.transactionType == TransactionType.transfer) {
        emit(TransferAccountsState(
          accounts,
          accounts.first,
          accounts.last,
        ));
      }
    }
  }

  FutureOr<void> _changeCategory(
    ChangeCategoryEvent event,
    Emitter<ExpenseState> emit,
  ) {
    selectedCategoryId = event.category.superId;
    emit(ChangeCategoryState(event.category));
  }

  FutureOr<void> _changeAccount(
    ChangeAccountEvent event,
    Emitter<ExpenseState> emit,
  ) {
    selectedAccountId = event.account.superId;
    emit(ChangeAccountState(event.account));
  }

  FutureOr<void> _updateDateTime(
    UpdateDateTimeEvent event,
    Emitter<ExpenseState> emit,
  ) {
    selectedDate = event.dateTime;
    emit(UpdateDateTimeState(event.dateTime));
  }

  FutureOr<void> _transferAccount(
    TransferAccountsEvent event,
    Emitter<ExpenseState> emit,
  ) {
    fromAccount = event.fromAccount;
    toAccount = event.toAccount;
    emit(
      TransferAccountsState(event.accounts, event.fromAccount, event.toAccount),
    );
  }
}
