part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class FetchExpenseFromIdEvent extends ExpenseEvent {
  final String? expenseId;

  const FetchExpenseFromIdEvent(this.expenseId);
}

class AddExpenseEvent extends ExpenseEvent {}

class UpdateExpenseEvent extends ExpenseEvent {}

class ClearExpenseEvent extends ExpenseEvent {
  final String expenseId;

  const ClearExpenseEvent(this.expenseId);
}

class ChangeExpenseEvent extends ExpenseEvent {
  final TransactonType transactionType;

  const ChangeExpenseEvent(this.transactionType);
}
