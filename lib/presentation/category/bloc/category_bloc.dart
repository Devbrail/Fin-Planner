import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../common/enum/box_types.dart';
import '../../../data/category/model/category.dart';
import '../../../domain/category/use_case/category_use_case.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required this.categoryUseCase,
  }) : super(AddCategoryInitial()) {
    on<CategoryEvent>((event, emit) {});
    on<FetchCategoriesEvent>((event, emit) => _fetchCategories(emit));
    on<AddCategoryEvent>((event, emit) => _addCategory(event, emit));
    on<CategoryDeleteEvent>((event, emit) => _deleteCategory(event, emit));
    on<CategoryRefreshEvent>((event, emit) => _refresh(emit));
    on<CategoryUpdateEvent>((event, emit) => _updateCategory(event, emit));
    on<FetchCategoryFromIdEvent>(
        (event, emit) => _fetchCategoryFromId(event, emit));
    on<CategoryIconSelectedEvent>((event, emit) => _categoryIcon(event, emit));
  }

  final CategoryUseCase categoryUseCase;
  late final box = Hive.box<Category>(BoxType.category.stringValue);
  int? selectedIcon;
  String? categoryTitle;
  String? categoryDesc;
  double? categoryBudget;
  Category? currentCategory;

  Future<void> _fetchCategoryFromId(
    FetchCategoryFromIdEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final int? categoryId = int.tryParse(event.categoryId ?? '');
    if (categoryId == null) return;

    final Category? category =
        await categoryUseCase.fetchCategoryFromId(categoryId);
    if (category != null) {
      categoryTitle = category.name;
      categoryDesc = category.description;
      categoryBudget = category.budget;
      selectedIcon = category.icon;
      currentCategory = category;
      emit(CategorySuccessState(category));
    }
  }

  _fetchCategories(Emitter<CategoryState> emit) async {
    final categories = await categoryUseCase.categories();
    emit(CategoriesListState(categories));
  }

  _addCategory(
    AddCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final String? title = categoryTitle;
    final String? description = categoryDesc;
    final int? icon = selectedIcon;
    final double? budget = categoryBudget;

    if (title == null) {
      return emit(const CategoryErrorState('Add category title'));
    }

    if (icon == null) {
      return emit(const CategoryErrorState('Select category icon'));
    }

    await categoryUseCase.addCategory(
      icon: icon,
      desc: description,
      name: title,
      budget: budget,
    );

    emit(const CategoryAddedState(isCategoryAddedOrUpdate: true));
  }

  Future<void> _updateCategory(
    CategoryUpdateEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final String? title = categoryTitle;
    final String? description = categoryDesc;
    final int? icon = selectedIcon;
    final double? budget = categoryBudget;

    if (title == null) {
      return emit(const CategoryErrorState('Add category title'));
    }

    if (description == null) {
      return emit(const CategoryErrorState('Add category description'));
    }

    if (icon == null) {
      return emit(const CategoryErrorState('Select category icon'));
    }
    if (currentCategory != null) {
      currentCategory!
        ..budget = budget
        ..description = description
        ..icon = icon
        ..name = title;

      await currentCategory!.save();
      emit(const CategoryAddedState());
    }
  }

  Future<void> _deleteCategory(
    CategoryDeleteEvent event,
    Emitter<CategoryState> emit,
  ) async {
    await categoryUseCase.deleteCategory(event.category.key);
    emit(CategoryDeletedState());
    add(FetchCategoriesEvent());
  }

  void _refresh(Emitter<CategoryState> emit) {
    add(FetchCategoriesEvent());
  }

  void _categoryIcon(
    CategoryIconSelectedEvent event,
    Emitter<CategoryState> emit,
  ) {
    emit(CategoryIconSelectedState(event.categoryIcon));
  }

  bool checkBudget() {
    final double budget = currentCategory?.budget ?? 0.0;
    if (budget > 0.0) {
      return true;
    }
    return false;
  }
}
