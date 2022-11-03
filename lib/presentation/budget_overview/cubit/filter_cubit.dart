import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../common/enum/filter_budget.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterBudgetState(FilterBudget.daily));

  void updateFilter(FilterBudget filterBudget) {
    emit(FilterBudgetState(filterBudget));
  }
}
