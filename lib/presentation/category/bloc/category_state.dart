part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class AddCategoryInitial extends CategoryState {}

class CategoriesListState extends CategoryState {
  final List<Category> categories;

  const CategoriesListState(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryAddedState extends CategoryState {
  final bool isCategoryAddedOrUpdate;

  const CategoryAddedState({this.isCategoryAddedOrUpdate = false});

  @override
  List<Object?> get props => [isCategoryAddedOrUpdate];
}

class CategoryDeletedState extends CategoryState {}

class CategoryErrorState extends CategoryState {
  final String errorString;

  const CategoryErrorState(this.errorString);
}

class CategorySuccessState extends CategoryState {
  final Category category;

  const CategorySuccessState(this.category);

  @override
  List<Object?> get props => [category];
}
