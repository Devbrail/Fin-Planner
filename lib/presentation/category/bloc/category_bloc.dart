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
    on<EditCategoryEvent>((event, emit) => _addCategory(event, emit));
    on<CategoryDeleteEvent>((event, emit) => _deleteCategory(event, emit));
    on<CategoryRefreshEvent>((event, emit) => _refresh(emit));
    on<CategoryUpdateEvent>((event, emit) => _updateCategory(event, emit));
    on<FetchCategoryFromIdEvent>(
        (event, emit) => _fetchCategoryFromId(event, emit));
    on<CategoryIconSelectedEvent>((event, emit) => _categoryIcon(event, emit));
  }
  final CategoryUseCase categoryUseCase;
  late final box = Hive.box<Category>(BoxType.category.stringValue);

  _fetchCategories(Emitter<CategoryState> emit) async {
    final categories = await categoryUseCase.categories();
    emit(CategoriesListState(categories));
  }

  _addCategory(
    EditCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final String? categoryTitle = event.title;
    final String? categoryDescription = event.description;
    final int? icon = event.icon;
    final double? budget = double.tryParse(event.budget ?? '');

    if (categoryTitle == null) {
      return emit(const CategoryErrorState('Add category title'));
    }

    if (categoryDescription == null) {
      return emit(const CategoryErrorState('Add category description'));
    }

    if (icon == null) {
      return emit(const CategoryErrorState('Select category icon'));
    }

    await categoryUseCase.addCategory(
      icon: icon,
      desc: categoryDescription,
      name: categoryTitle,
      budget: budget,
    );

    emit(const CategoryAddedState(isCategoryAddedOrUpdate: true));
  }

  _updateCategory(
    CategoryUpdateEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final String? categoryTitle = event.title;
    final String? categoryDescription = event.description;
    final int? icon = event.icon;
    final double? budget = double.tryParse(event.budget ?? '');

    if (categoryTitle == null) {
      return emit(const CategoryErrorState('Add category title'));
    }

    if (categoryDescription == null) {
      return emit(const CategoryErrorState('Add category title'));
    }
    if (icon == null) {
      return emit(const CategoryErrorState('Select category icon'));
    }

    event.category!
      ..budget = budget
      ..description = categoryDescription
      ..icon = icon
      ..name = categoryTitle;

    await event.category!.save();
    emit(const CategoryAddedState());
  }

  _deleteCategory(
    CategoryDeleteEvent event,
    Emitter<CategoryState> emit,
  ) async {
    await categoryUseCase.deleteCategory(event.category.key);
    emit(CategoryDeletedState());
    add(FetchCategoriesEvent());
  }

  _refresh(Emitter<CategoryState> emit) {
    add(FetchCategoriesEvent());
  }

  _fetchCategoryFromId(
    FetchCategoryFromIdEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final int? categoryId = int.tryParse(event.categoryId ?? '');
    if (categoryId == null) return;

    final Category? category =
        await categoryUseCase.fetchCategoryFromId(categoryId);
    if (category != null) {
      emit(CategorySuccessState(category));
    }
  }

  _categoryIcon(
    CategoryIconSelectedEvent event,
    Emitter<CategoryState> emit,
  ) {
    emit(CategoryIconSelectedState(event.categoryIcon));
  }
}
