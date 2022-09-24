part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategoriesEvent extends CategoryEvent {}

class CategoryRefreshEvent extends CategoryEvent {}

class EditCategoryEvent extends CategoryEvent {
  final String? title;
  final String? description;
  final int icon;
  final String? budget;

  EditCategoryEvent({
    required this.title,
    required this.description,
    required this.icon,
    required this.budget,
  });
}

class CategoryUpdateEvent extends CategoryEvent {
  final Category? category;
  final String? title;
  final String? description;
  final int icon;
  final String? budget;

  CategoryUpdateEvent({
    required this.title,
    required this.description,
    required this.icon,
    required this.budget,
    required this.category,
  });
}

class CategoryDeleteEvent extends CategoryEvent {
  final Category category;

  CategoryDeleteEvent(this.category);
}

class FetchCategoryFromIdEvent extends CategoryEvent {
  final String? categoryId;

  FetchCategoryFromIdEvent(this.categoryId);
}
