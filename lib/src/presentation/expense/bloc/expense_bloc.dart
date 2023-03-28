import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/enum/transaction.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../data/category/model/category_model.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/account/use_case/get_account_use_case.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';
import '../../../domain/expense/use_case/update_expense_use_case.dart';

import '../pages/expense_page.dart';

part 'expense_event.dart';
part 'expense_state.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({
    required this.expenseUseCase,
    required this.accountUseCase,
    required this.addExpenseUseCase,
    required this.deleteExpenseUseCase,
    required this.updateExpensesUseCase,
  }) : super(ExpenseInitial()) {
    on<ExpenseEvent>((event, emit) {});
    on<AddOrUpdateExpenseEvent>(_addExpense);
    on<ClearExpenseEvent>(_deleteExpense);
    on<ChangeExpenseEvent>(_changeExpense);
    on<FetchExpenseFromIdEvent>(_fetchExpenseFromId);
    on<ChangeCategoryEvent>(_changeCategory);
    on<ChangeAccountEvent>(_changeAccount);
    on<UpdateDateTimeEvent>(_updateDateTime);
  }

  final GetExpenseUseCase expenseUseCase;
  final AddExpenseUseCase addExpenseUseCase;
  final GetAccountUseCase accountUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;
  final UpdateExpensesUseCase updateExpensesUseCase;

  String? expenseName;
  double? expenseAmount;
  int? selectedCategoryId;
  int? selectedAccountId;
  Expense? currentExpense;
  String? currentDescription;
  DateTime selectedDate = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  TransactionType transactionType = TransactionType.expense;

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
      selectedAccountId = expense.accountId;
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
    transactionType = event.transactionType;
    emit(ChangeExpenseState(event.transactionType));
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
}
