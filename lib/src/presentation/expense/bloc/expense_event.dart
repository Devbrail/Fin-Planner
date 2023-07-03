part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class FetchExpenseFromIdEvent extends ExpenseEvent {
  const FetchExpenseFromIdEvent(this.expenseId);

  final String? expenseId;
}

class AddOrUpdateExpenseEvent extends ExpenseEvent {
  const AddOrUpdateExpenseEvent(this.isAdding);

  final bool isAdding;
}

class ClearExpenseEvent extends ExpenseEvent {
  const ClearExpenseEvent(this.expenseId);

  final String expenseId;
}

class ChangeExpenseEvent extends ExpenseEvent {
  const ChangeExpenseEvent(this.transactionType);

  final TransactionType transactionType;
}

class AddRecurringEvent extends ExpenseEvent {
  const AddRecurringEvent();
}

class ChangeCategoryEvent extends ExpenseEvent {
  const ChangeCategoryEvent(this.category);

  final Category category;
}

class ChangeAccountEvent extends ExpenseEvent {
  const ChangeAccountEvent(this.account);

  final Account account;
}

class UpdateDateTimeEvent extends ExpenseEvent {
  const UpdateDateTimeEvent(this.dateTime);

  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

class TransferAccountEvent extends ExpenseEvent {
  const TransferAccountEvent(
    this.account, {
    this.isFromAccount = false,
  });

  final Account account;
  final bool isFromAccount;

  @override
  List<Object> get props => [account, isFromAccount];
}

class FetchDefaultCategoryEvent extends ExpenseEvent {}
