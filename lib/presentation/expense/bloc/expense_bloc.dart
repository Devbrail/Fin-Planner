import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../common/enum/transaction.dart';
import '../../../data/expense/model/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';

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
      emit(ExpenseSuccessState(expense));
      expenseAmount = expense.currency;
      expenseName = expense.name;
      selectedCategoryId = expense.categoryId;
      selectedAccountId = expense.accountId;
      selectedDate = expense.time;
      selectedType = expense.type ?? TransactionType.expense;
      currentExpense = expense;
    }
  }

  Future<void> _addExpense(
    AddExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final double? validAmount = expenseAmount;
    final String? name = expenseName;
    final int? categoryId = selectedCategoryId;
    final int? accountId = selectedAccountId;
    final DateTime? dateTime = selectedDate;

    if (validAmount == null || validAmount == 0.0) {
      return emit(const ExpenseErrorState('Enter valid amout'));
    }

    if (name == null) {
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
      name,
      validAmount,
      dateTime,
      categoryId,
      accountId,
      selectedType,
    );

    emit(const ExpenseAdded(isAddOrUpdate: true));
  }

  Future<void> _updateExpense(
    UpdateExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final double? validAmount = expenseAmount;
    final String? name = expenseName;
    final int? categoryId = selectedCategoryId;
    final int? accountId = selectedAccountId;
    final DateTime? dateTime = selectedDate;
    if (validAmount == null || validAmount == 0.0) {
      return emit(const ExpenseErrorState('Enter valid amout'));
    }

    if (name == null) {
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
    if (currentExpense != null) {
      currentExpense!
        ..accountId = accountId
        ..categoryId = categoryId
        ..currency = validAmount
        ..name = name
        ..time = dateTime
        ..type = selectedType;

      await currentExpense!.save();

      emit(const ExpenseAdded());
    }
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
}
