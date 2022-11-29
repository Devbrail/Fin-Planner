import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/enum/filter_budget.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit() : super(const SummaryFilterBudgetState());

  void updateFilter(FilterBudget budget) {
    emit(SummaryFilterBudgetState(budget: budget));
  }
}
