import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/category/model/category.dart';
import 'package:meta/meta.dart';

import '../../../common/enum/transaction.dart';
import '../../../data/expense/model/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc(this.expenseUseCase) : super(ExpenseInitial()) {
    on<ExpenseEvent>((event, emit) {});
    on<AddOrUpdateExpenseEvent>(_addExpense);
    on<ClearExpenseEvent>(_clearExpense);
    on<ChangeExpenseEvent>(_changeExpense);
    on<FetchExpenseFromIdEvent>(_fetchExpenseFromId);
    on<ChangeCategoryEvent>(_changeCategory);
    on<ChangeAccountEvent>(_changeAccount);
  }

  final ExpenseUseCase expenseUseCase;
  String? expenseName;
  double? expenseAmount;
  int? selectedCategoryId;
  int? selectedAccountId;
  Expense? currentExpense;
  late DateTime? selectedDate = DateTime.now();
  late TransactionType selectedType = TransactionType.expense;

  Future<void> _fetchExpenseFromId(
    FetchExpenseFromIdEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final int? expenseId = int.tryParse(event.expenseId ?? '');
    if (expenseId == null) return;

    final Expense? expense = await expenseUseCase.fetchExpenseFromId(expenseId);
    if (expense != null) {
      expenseAmount = expense.currency;
      expenseName = expense.name;
      selectedCategoryId = expense.categoryId;
      selectedAccountId = expense.accountId;
      selectedDate = expense.time;
      selectedType = expense.type ?? TransactionType.expense;
      currentExpense = expense;
      emit(ExpenseSuccessState(expense));
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
      await expenseUseCase.addExpense(
        name,
        validAmount,
        dateTime,
        categoryId,
        accountId,
        selectedType,
      );
    } else {
      if (currentExpense != null) {
        currentExpense!
          ..accountId = accountId
          ..categoryId = categoryId
          ..currency = validAmount
          ..name = name
          ..time = dateTime
          ..type = selectedType;

        await currentExpense!.save();
      }
    }
    emit(ExpenseAdded(isAddOrUpdate: event.isAdding));
  }

  Future<void> _clearExpense(
    ClearExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final int? expenseId = int.tryParse(event.expenseId);
    if (expenseId == null) return;
    await expenseUseCase.clearExpense(expenseId);
    emit(ExpenseDeletedState());
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
