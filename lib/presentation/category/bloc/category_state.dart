part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class AddCategoryInitial extends CategoryState {}

class CategoriesListState extends CategoryState {
  final List<Category> categories;

  CategoriesListState(this.categories);
}

class CategoryAddedState extends CategoryState {}

class CategoryDeletedState extends CategoryState {}
