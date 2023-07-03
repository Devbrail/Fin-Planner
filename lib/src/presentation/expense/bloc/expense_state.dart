part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseAdded extends ExpenseState {
  const ExpenseAdded({this.isAddOrUpdate = false});

  final bool isAddOrUpdate;

  @override
  List<Object> get props => [isAddOrUpdate];
}

class ExpenseDeletedState extends ExpenseState {}

class ChangeTransactionTypeState extends ExpenseState {
  const ChangeTransactionTypeState(this.transactionType);

  final TransactionType transactionType;

  @override
  List<Object> get props => [transactionType];
}

class ChangeRecurringTypeState extends ExpenseState {
  const ChangeRecurringTypeState(this.recurringType);

  final RecurringType recurringType;

  @override
  List<Object> get props => [recurringType];
}

class ExpenseErrorState extends ExpenseState {
  const ExpenseErrorState(this.errorString);

  final String errorString;

  @override
  List<Object> get props => [errorString];
}

class ExpenseSuccessState extends ExpenseState {
  const ExpenseSuccessState(this.expense);

  final ExpenseModel expense;

  @override
  List<Object> get props => [expense];
}

class ChangeCategoryState extends ExpenseState {
  const ChangeCategoryState(this.category);

  final CategoryModel category;

  @override
  List<Object> get props => [category];
}

class ChangeAccountState extends ExpenseState {
  const ChangeAccountState(this.account);

  final AccountModel account;

  @override
  List<Object> get props => [account];
}

class UpdateDateTimeState extends ExpenseState {
  const UpdateDateTimeState(this.dateTime);

  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

class TransferAccountState extends ExpenseState {
  const TransferAccountState(
    this.isFromAccount,
    this.fromAccount,
    this.toAccount,
  );

  final bool isFromAccount;
  final Account? fromAccount, toAccount;

  @override
  List<Object> get props => [isFromAccount];
}

class DefaultCategoriesState extends ExpenseState {
  const DefaultCategoriesState(this.categories);

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}
