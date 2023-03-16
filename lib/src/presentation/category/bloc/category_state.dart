part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class AddCategoryInitial extends CategoryState {}

class CategoriesListState extends CategoryState {
  final List<CategoryModel> categories;

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
  final CategoryModel category;

  const CategorySuccessState(this.category);

  @override
  List<Object?> get props => [category];
}

class CategoryIconSelectedState extends CategoryState {
  final int categoryIcon;

  const CategoryIconSelectedState(this.categoryIcon);

  @override
  List<Object?> get props => [categoryIcon];
}

class CategoryColorSelectedState extends CategoryState {
  final int categoryColor;

  const CategoryColorSelectedState(this.categoryColor);

  @override
  List<Object?> get props => [categoryColor, identityHashCode(this)];
}

class UpdateCategoryBudgetState extends CategoryState {
  final bool isBudget;

  const UpdateCategoryBudgetState(this.isBudget);

  @override
  List<Object?> get props => [isBudget];
}
