part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoriesEvent extends CategoryEvent {}

class CategoryRefreshEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {}

class CategoryUpdateEvent extends CategoryEvent {}

class CategoryDeleteEvent extends CategoryEvent {
  final Category category;

  const CategoryDeleteEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class FetchCategoryFromIdEvent extends CategoryEvent {
  final String? categoryId;

  const FetchCategoryFromIdEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class CategoryIconSelectedEvent extends CategoryEvent {
  final int categoryIcon;

  const CategoryIconSelectedEvent(this.categoryIcon);

  @override
  List<Object?> get props => [categoryIcon];
}
