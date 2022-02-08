part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class FetchCategoriesEvent extends CategoryEvent {}

class CategoryRefreshEvent extends CategoryEvent {}

class EditCategoryEvent extends CategoryEvent {
  final String title;
  final String description;
  final int icon;

  EditCategoryEvent({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class CategoryUpdateEvent extends CategoryEvent {
  final Category category;

  CategoryUpdateEvent(this.category);
}

class CategoryDeleteEvent extends CategoryEvent {
  final Category category;

  CategoryDeleteEvent(this.category);
}
