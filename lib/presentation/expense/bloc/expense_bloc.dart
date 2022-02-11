import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/constants/util.dart';
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
  }

  final ExpenseUseCase expenseUseCase;

  Future<void> _addExpense(
    AddExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    double validAmount = 0.0;
    try {
      validAmount = validDate(event.amount);
    } catch (_) {
      return;
    }

    await expenseUseCase.addExpense(
      event.name,
      validAmount,
      event.time,
      event.categoryId,
      event.accountId,
      event.type,
    );
    emit(const ExpenseAdded(isAddOrUpdate: true));
  }

  Future<void> _updateExpense(
    UpdateExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(const ExpenseAdded());
  }

  Future<void> _clearExpense(
    ClearExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    await expenseUseCase.clearExpense(event.expense);
    emit(ExpenseDeletedState());
  }
}
