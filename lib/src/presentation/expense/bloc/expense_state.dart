part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseAdded extends ExpenseState {
  final bool isAddOrUpdate;

  const ExpenseAdded({this.isAddOrUpdate = false});
  @override
  List<Object> get props => [isAddOrUpdate];
}

class ExpenseDeletedState extends ExpenseState {}

class ChangeTransactionTypeState extends ExpenseState {
  final TransactionType transactionType;

  const ChangeTransactionTypeState(this.transactionType);

  @override
  List<Object> get props => [transactionType];
}

class ChangeRecurringTypeState extends ExpenseState {
  final RecurringType recurringType;

  const ChangeRecurringTypeState(this.recurringType);

  @override
  List<Object> get props => [recurringType];
}

class ExpenseErrorState extends ExpenseState {
  final String errorString;

  const ExpenseErrorState(this.errorString);

  @override
  List<Object> get props => [errorString];
}

class ExpenseSuccessState extends ExpenseState {
  final ExpenseModel expense;

  const ExpenseSuccessState(this.expense);

  @override
  List<Object> get props => [expense];
}

class ChangeCategoryState extends ExpenseState {
  final CategoryModel category;

  const ChangeCategoryState(this.category);

  @override
  List<Object> get props => [category];
}

class ChangeAccountState extends ExpenseState {
  final AccountModel account;

  const ChangeAccountState(this.account);

  @override
  List<Object> get props => [account];
}

class UpdateDateTimeState extends ExpenseState {
  final DateTime dateTime;

  const UpdateDateTimeState(this.dateTime);

  @override
  List<Object> get props => [dateTime];
}

class TransferAccountsState extends ExpenseState {
  final List<Account> accounts;
  final Account fromAccount, toAccount;

  const TransferAccountsState(
    this.accounts,
    this.fromAccount,
    this.toAccount,
  );

  @override
  List<Object> get props => [accounts, fromAccount, toAccount];
}
