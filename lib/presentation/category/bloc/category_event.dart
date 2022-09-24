part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoriesEvent extends CategoryEvent {}

class CategoryRefreshEvent extends CategoryEvent {}

class EditCategoryEvent extends CategoryEvent {
  final String? title;
  final String? description;
  final int? icon;
  final String? budget;

  const EditCategoryEvent({
    required this.title,
    required this.description,
    required this.icon,
    required this.budget,
  });
  @override
  List<Object?> get props => [title, description, icon, budget];
}

class CategoryUpdateEvent extends CategoryEvent {
  final Category? category;
  final String? title;
  final String? description;
  final int? icon;
  final String? budget;

  const CategoryUpdateEvent({
    required this.title,
    required this.description,
    required this.icon,
    required this.budget,
    required this.category,
  });

  @override
  List<Object?> get props => [title, description, icon, budget, category];
}

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
