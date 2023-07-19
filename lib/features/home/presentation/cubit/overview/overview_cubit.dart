import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/category/domain/use_case/category_use_case.dart';
import 'package:paisa/features/transaction/domain/entities/expense.dart';
import 'package:paisa/features/transaction/domain/use_case/expense_use_case.dart';

@injectable
class OverviewCubit extends Cubit<BudgetState> {
  OverviewCubit(
    this.getExpensesUseCase,
    this.getCategoryUseCase,
    this.getCategoriesUseCase,
  ) : super(BudgetInitial());

  final GetDefaultCategoriesUseCase getCategoriesUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final GetExpensesUseCase getExpensesUseCase;
  String? selectedTime;

  List<String> _filterTimes = [];
  final List<Category> _defaultCategories = [];
  Map<String, List<Expense>> _groupedExpenses = {};

  void fetchBudgetSummary(List<Expense> expenses, FilterExpense filterExpense) {
    if (expenses.isEmpty) {
      emit(EmptyFilterListState());
    } else {
      _groupedExpenses = groupBy(
          expenses, (Expense expense) => expense.time.formatted(filterExpense));
      final String time = selectedTime = _groupedExpenses.keys.first;
      _filterTimes = _groupedExpenses.keys.toList();
      emit(InitialSelectedState(time, _filterTimes));
      Future.delayed(Duration.zero)
          .then((value) => fetchSelectedTimeExpenses(time));
    }
  }

  void updateFilterTime(String time) {
    selectedTime = time;
    emit(InitialSelectedState(selectedTime!, _filterTimes));
    fetchSelectedTimeExpenses(time);
  }

  void fetchSelectedTimeExpenses(String time) {
    final List<Expense> selectedTimeExpenses = _groupedExpenses[time] ?? [];
    final Map<Category, List<Expense>> categoryGroupedExpenses =
        groupBy(selectedTimeExpenses, (Expense expense) {
      return getCategoryUseCase(expense.categoryId) ?? _defaultCategories.first;
    });
    final List<MapEntry<Category, List<Expense>>> mapExpenses =
        categoryGroupedExpenses.entries.toList().sorted(
            (a, b) => b.value.totalExpense.compareTo(a.value.totalExpense));
    emit(FilteredCategoryListState(
      mapExpenses,
      selectedTimeExpenses.total,
    ));
  }

  void fetchDefaultCategory() {
    _defaultCategories.addAll(getCategoriesUseCase.call());
  }
}

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {}

class InitialSelectedState extends BudgetState {
  const InitialSelectedState(this.selectedTime, this.filerTimes);

  final List<String> filerTimes;
  final String selectedTime;

  @override
  List<Object> get props => [selectedTime, filerTimes];
}

class FilteredCategoryListState extends BudgetState {
  const FilteredCategoryListState(this.categoryGrouped, this.totalExpense);

  final List<MapEntry<Category, List<Expense>>> categoryGrouped;
  final double totalExpense;
}

class EmptyFilterListState extends BudgetState {}
