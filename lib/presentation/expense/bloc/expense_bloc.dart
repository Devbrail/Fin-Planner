import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/enum/transaction.dart';
import '../../../data/expense/model/expense.dart';
import '../../../domain/landing/usecase/expense_use_case.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc(this.expenseUseCase) : super(ExpenseInitial()) {
    on<ExpenseEvent>((event, emit) {});
    on<AddExpenseEvent>((event, emit) => _addExpense(event, emit));
    on<UpdateExpenseEvent>((event, emit) => _updateExpense(event, emit));
    on<ClearExpenseEvent>((event, emit) => _clearExpense(event, emit));
    on<ChangeExpenseEvent>((event, emit) => _changeExpense(event, emit));
    on<FetchExpenseFromIdEvent>(
        (event, emit) => _fetchExpenseFromId(event, emit));
  }

  final ExpenseUseCase expenseUseCase;

  Future<void> _fetchExpenseFromId(
    FetchExpenseFromIdEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final int? expenseId = event.expenseId;
    if (expenseId == null) {
      return;
    }
    final Expense? expense = await expenseUseCase.fetchExpenseFromId(expenseId);
    if (expense != null) {
      emit(ExpenseSuccessState(expense));
    }
  }

  Future<void> _addExpense(
    AddExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final double? validAmount = double.tryParse(event.amount ?? '0.0');
    final String? expenseName = event.name;
    final int? categoryId = event.categoryId;
    final int? accountId = event.accountId;
    final DateTime? dateTime = event.time;
    if (validAmount == null || validAmount == 0.0) {
      return emit(const ExpenseErrorState('Enter valid amout'));
    }

    if (expenseName == null) {
      return emit(const ExpenseErrorState('Enter expense name'));
    }

    if (categoryId == null) {
      return emit(const ExpenseErrorState('Select catergory'));
    }
    if (accountId == null) {
      return emit(const ExpenseErrorState('Select account'));
    }
    if (dateTime == null) {
      return emit(const ExpenseErrorState('Select time'));
    }

    await expenseUseCase.addExpense(
      expenseName,
      validAmount,
      dateTime,
      categoryId,
      accountId,
      event.type,
    );

    emit(const ExpenseAdded(isAddOrUpdate: true));
  }

  Future<void> _updateExpense(
    UpdateExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final double? validAmount = double.tryParse(event.amount ?? '0.0');
    final String? expenseName = event.name;
    final int? categoryId = event.categoryId;
    final int? accountId = event.accountId;
    final DateTime? dateTime = event.time;
    if (validAmount == null || validAmount == 0.0) {
      return emit(const ExpenseErrorState('Enter valid amout'));
    }

    if (expenseName == null) {
      return emit(const ExpenseErrorState('Enter expense name'));
    }

    if (categoryId == null) {
      return emit(const ExpenseErrorState('Select catergory'));
    }
    if (accountId == null) {
      return emit(const ExpenseErrorState('Select account'));
    }
    if (dateTime == null) {
      return emit(const ExpenseErrorState('Select time'));
    }
    if (event.expense == null) {
      return;
    }
    event.expense!
      ..accountId = accountId
      ..categoryId = categoryId
      ..currency = validAmount
      ..name = expenseName
      ..time = dateTime
      ..type = event.type;

    await event.expense!.save();

    emit(const ExpenseAdded());
  }

  Future<void> _clearExpense(
    ClearExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    await expenseUseCase.clearExpense(event.expenseId);
    emit(ExpenseDeletedState());
  }

  void _changeExpense(ChangeExpenseEvent event, Emitter<ExpenseState> emit) {
    emit(ChangeExpenseState(event.transactionType));
  }
}
