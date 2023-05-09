import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.filterExpenseUseCase) : super(SearchInitial());

  final FilterExpenseUseCase filterExpenseUseCase;
  int selectedAccountId = -1, selectedCategoryId = -1;

  void searchWithQuery(String query) {
    if (query.isEmpty) {
      return emit(SearchQueryEmptyState());
    }
    final List<Expense> expenses = filterExpenseUseCase(
      query,
      selectedAccountId,
      selectedCategoryId,
    );
    if (expenses.isEmpty) {
      return emit(SearchEmptyState());
    } else {
      emit(SearchResultState(expenses));
    }
  }
}
