import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/enum/filter_budget.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterBudgetState(FilterBudget.daily));

  void updateFilterBudget(FilterBudget filterBudget) =>
      emit(FilterBudgetState(filterBudget));
}

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
