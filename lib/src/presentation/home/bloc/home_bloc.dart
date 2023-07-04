import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/common.dart';
import '../../../domain/category/use_case/category_use_case.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    @Named('settings') this.settings,
    this.expensesUseCase,
    this.defaultCategoriesUseCase,
  ) : super(const CurrentIndexState(0)) {
    on<HomeEvent>((event, emit) {});
    on<CurrentIndexEvent>(_currentIndex);
  }

  int selectedIndex = 0;
  final Box<dynamic> settings;
  final GetExpensesUseCase expensesUseCase;
  final GetDefaultCategoriesUseCase defaultCategoriesUseCase;

  PageType getPageFromIndex(int index) {
    switch (index) {
      case 1:
        return PageType.accounts;
      case 2:
        return PageType.debts;
      case 3:
        return PageType.overview;
      case 4:
        return PageType.category;
      case 5:
        return PageType.budget;
      case 6:
        return PageType.recurring;
      case 0:
      default:
        return PageType.home;
    }
  }

  void _currentIndex(
    CurrentIndexEvent event,
    Emitter<HomeState> emit,
  ) {
    if (selectedIndex != event.currentPage) {
      selectedIndex = event.currentPage;
      emit(CurrentIndexState(selectedIndex));
    }
  }
}
