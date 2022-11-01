import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_paisa/common/enum/filter_budget.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit() : super(const SummaryFilterBudgetState());

  void updateFilter(FilterBudget budget) {
    emit(SummaryFilterBudgetState(budget: budget));
  }
}
