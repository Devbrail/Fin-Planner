import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';
import 'package:paisa/features/search/domain/use_case/filter_expense_use_case.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchUseCase) : super(SearchInitial());

  final SearchUseCase searchUseCase;
  List<int> selectedAccountId = [], selectedCategoryId = [];

  void searchWithQuery(String query) {
    if (query.isEmpty) {
      return emit(SearchQueryEmptyState());
    }
    final List<CombinedTransactionEntity> expenses =
        []; /* searchUseCase(
      params: SearchParams(
        query: query,
        accounts: selectedAccountId,
        categories: selectedCategoryId,
      ),
    ); */
    if (expenses.isEmpty) {
      return emit(SearchEmptyState());
    } else {
      emit(SearchResultState(expenses));
    }
  }
}
