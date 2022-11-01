part of 'summary_cubit.dart';

abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

class SummaryFilterBudgetState extends SummaryState {
  final FilterBudget budget;

  const SummaryFilterBudgetState({this.budget = FilterBudget.daily});

  @override
  List<Object> get props => [budget];
}
