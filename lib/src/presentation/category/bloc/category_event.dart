part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class AddOrUpdateCategoryEvent extends CategoryEvent {
  final bool isAddOrUpdate;

  const AddOrUpdateCategoryEvent(this.isAddOrUpdate);
  @override
  List<Object?> get props => [isAddOrUpdate];
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

  FetchCategoryFromIdEvent copyWith({
    String? categoryId,
  }) =>
      FetchCategoryFromIdEvent(categoryId ?? this.categoryId);
}

class CategoryIconSelectedEvent extends CategoryEvent {
  final int categoryIcon;

  const CategoryIconSelectedEvent(this.categoryIcon);

  @override
  List<Object?> get props => [categoryIcon];
}

class CategoryColorSelectedEvent extends CategoryEvent {
  final int categoryColor;

  const CategoryColorSelectedEvent(this.categoryColor);

  @override
  List<Object?> get props => [categoryColor];
}

class UpdateCategoryBudgetEvent extends CategoryEvent {
  final bool isBudget;

  const UpdateCategoryBudgetEvent(this.isBudget);
  @override
  List<Object?> get props => [isBudget];
}
