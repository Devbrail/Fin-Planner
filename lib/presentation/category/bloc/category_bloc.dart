import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/category/model/category.dart';
import '../../../domain/category/usecase/category_use_case.dart';

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
    on<CategoryUpdateEvent>((event, emit) => _update(event, emit));
  }
  final CategoryUseCase categoryUseCase;

  _fetchCategories(Emitter<CategoryState> emit) async {
    final categories = await categoryUseCase.categories();
    emit(CategoriesListState(categories));
  }

  _addCategory(
    EditCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    await categoryUseCase.addCategory(
      icon: event.icon,
      desc: event.description,
      name: event.title,
    );
    emit(CategoryAddedState());
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

  _update(CategoryUpdateEvent event, Emitter<CategoryState> emit) async {
    await categoryUseCase.updateCategory(event.category);
    emit(CategoryAddedState());
  }
}
