part of 'expense_bloc.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseAdded extends ExpenseState {
  final bool isAddOrUpdate;

  const ExpenseAdded({this.isAddOrUpdate = false});
}

class ExpenseDeletedState extends ExpenseState {}

class ChangeExpenseState extends ExpenseState {
  final TransactonType transactionType;

  const ChangeExpenseState(this.transactionType);
  @override
  List<Object> get props => [transactionType];
}

class ExpenseErrorState extends ExpenseState {
  final String errorString;

  const ExpenseErrorState(this.errorString);
}

class ExpenseSuccessState extends ExpenseState {
  final Expense expense;

  const ExpenseSuccessState(this.expense);
}
