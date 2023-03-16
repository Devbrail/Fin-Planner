import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/enum/transaction.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../data/category/model/category_model.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../../domain/account/use_case/get_account_use_case.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';

part 'expense_event.dart';
part 'expense_state.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({
    required this.expenseUseCase,
    required this.accountUseCase,
    required this.addExpenseUseCase,
    required this.deleteExpenseUseCase,
  }) : super(ExpenseInitial()) {
    on<ExpenseEvent>((event, emit) {});
    on<AddOrUpdateExpenseEvent>(_addExpense);
    on<ClearExpenseEvent>(_clearExpense);
    on<ChangeExpenseEvent>(_changeExpense);
    on<FetchExpenseFromIdEvent>(_fetchExpenseFromId);
    on<ChangeCategoryEvent>(_changeCategory);
    on<ChangeAccountEvent>(_changeAccount);
  }

  final GetExpenseUseCase expenseUseCase;
  final AddExpenseUseCase addExpenseUseCase;
  final GetAccountUseCase accountUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;

  String? expenseName;
  double? expenseAmount;
  int? selectedCategoryId;
  int? selectedAccountId;
  ExpenseModel? currentExpense;
  String? currentDescription;
  DateTime? selectedDate = DateTime.now();
  TransactionType transactionType = TransactionType.expense;

  Future<void> _fetchExpenseFromId(
    FetchExpenseFromIdEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final int? expenseId = int.tryParse(event.expenseId ?? '');
    if (expenseId == null) return;

    final ExpenseModel? expense = await expenseUseCase(expenseId);
    if (expense != null) {
      expenseAmount = expense.currency;
      expenseName = expense.name;
      selectedCategoryId = expense.categoryId;
      selectedAccountId = expense.accountId;
      selectedDate = expense.time;
      transactionType = expense.type ?? TransactionType.expense;
      currentDescription = expense.description;
      currentExpense = expense;
      emit(ExpenseSuccessState(expense));
      add(ChangeExpenseEvent(transactionType));
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
    final DateTime? dateTime = selectedDate;
    final String? description = currentDescription;

    if (validAmount == null || validAmount == 0.0) {
      return emit(const ExpenseErrorState('Enter valid amount'));
    }

    if (name == null) {
      return emit(const ExpenseErrorState('Enter expense name'));
    }
    if (accountId == null) {
      return emit(const ExpenseErrorState('Select account'));
    }
    if (categoryId == null) {
      return emit(const ExpenseErrorState('Select category'));
    }
    if (dateTime == null) {
      return emit(const ExpenseErrorState('Select time'));
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
      await currentExpense!.save();
    }
    emit(ExpenseAdded(isAddOrUpdate: event.isAdding));
  }

  Future<void> _clearExpense(
    ClearExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    if (currentExpense != null) {
      final AccountModel? account = accountUseCase(currentExpense!.accountId);
      if (account != null) {
        account.amount = (currentExpense!.currency + account.amount!);
        await account.save();
      }
      await deleteExpenseUseCase(currentExpense!.key);
      emit(ExpenseDeletedState());
    } else {
      emit(const ExpenseErrorState('Error deleting expense'));
    }
  }

  void _changeExpense(ChangeExpenseEvent event, Emitter<ExpenseState> emit) {
    emit(ChangeExpenseState(event.transactionType));
  }

  FutureOr<void> _changeCategory(
    ChangeCategoryEvent event,
    Emitter<ExpenseState> emit,
  ) {
    selectedCategoryId = event.category.key;
    emit(ChangeCategoryState(event.category));
  }

  FutureOr<void> _changeAccount(
    ChangeAccountEvent event,
    Emitter<ExpenseState> emit,
  ) {
    selectedAccountId = event.account.key;
    emit(ChangeAccountState(event.account));
  }
}
