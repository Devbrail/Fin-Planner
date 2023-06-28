part of 'summary_cubit.dart';

abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

class SummaryInitial extends SummaryState {}

class SuccessState extends SummaryState {
  const SuccessState(this.expenses);

  final List<EnhancedExpense> expenses;

  @override
  List<Object> get props => [expenses];
}
