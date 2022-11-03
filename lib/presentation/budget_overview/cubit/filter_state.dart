part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterBudgetState extends FilterState {
  final FilterBudget filterBudget;

  const FilterBudgetState(this.filterBudget);

  @override
  List<Object> get props => [filterBudget];
}
