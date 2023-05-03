part of 'search_cubit_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchResultState extends SearchState {
  final List<Expense> expenses;

  const SearchResultState(this.expenses);
}

class SearchQueryEmptyState extends SearchState {}

class SearchEmptyState extends SearchState {}
