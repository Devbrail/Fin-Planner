part of 'summary_cubit.dart';

abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

class SummaryInitial extends SummaryState {}

class SummaryExpenses extends SummaryState {
  final List<Expense> expenses;

  const SummaryExpenses(this.expenses);
}
