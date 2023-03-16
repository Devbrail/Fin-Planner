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

class AddOrUpdateExpenseEvent extends ExpenseEvent {
  final bool isAdding;

  const AddOrUpdateExpenseEvent(this.isAdding);
}

class ClearExpenseEvent extends ExpenseEvent {
  final String expenseId;

  const ClearExpenseEvent(this.expenseId);
}

class ChangeExpenseEvent extends ExpenseEvent {
  final TransactionType transactionType;

  const ChangeExpenseEvent(this.transactionType);
}

class ChangeCategoryEvent extends ExpenseEvent {
  final CategoryModel category;

  const ChangeCategoryEvent(this.category);
}

class ChangeAccountEvent extends ExpenseEvent {
  final AccountModel account;

  const ChangeAccountEvent(this.account);
}
