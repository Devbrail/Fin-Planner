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
