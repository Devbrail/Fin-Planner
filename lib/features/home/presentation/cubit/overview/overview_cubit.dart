import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/category/domain/use_case/category_use_case.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/use_case/transaction_use_case.dart';

@injectable
class OverviewCubit extends Cubit<BudgetState> {
  OverviewCubit(
    this.getExpensesUseCase,
    this.getCategoryUseCase,
    this.getCategoriesUseCase,
  ) : super(BudgetInitial());

  final GetDefaultCategoriesUseCase getCategoriesUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final GetTransactionsUseCase getExpensesUseCase;
  String? selectedTime;

  List<String> _filterTimes = [];
  final List<CategoryEntity> _defaultCategories = [];
  Map<String, List<TransactionEntity>> _groupedExpenses = {};

  void fetchBudgetSummary(
      List<TransactionEntity> expenses, FilterExpense filterExpense) {
    if (expenses.isEmpty) {
      emit(EmptyFilterListState());
    } else {
      _groupedExpenses = groupBy(
          expenses,
          (TransactionEntity expense) =>
              expense.time!.formatted(filterExpense));
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
    final List<TransactionEntity> selectedTimeExpenses =
        _groupedExpenses[time] ?? [];
    final Map<CategoryEntity, List<TransactionEntity>> categoryGroupedExpenses =
        groupBy(selectedTimeExpenses, (TransactionEntity expense) {
      return getCategoryUseCase(GetCategoryParams(expense.categoryId)) ??
          _defaultCategories.first;
    });
    final List<MapEntry<CategoryEntity, List<TransactionEntity>>> mapExpenses =
        categoryGroupedExpenses.entries.toList().sorted(
            (a, b) => b.value.totalExpense.compareTo(a.value.totalExpense));
    emit(FilteredCategoryListState(
      mapExpenses,
      selectedTimeExpenses.total,
    ));
  }

  void fetchDefaultCategory() {
    _defaultCategories.addAll(getCategoriesUseCase(NoParams()));
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

  final List<MapEntry<CategoryEntity, List<TransactionEntity>>> categoryGrouped;
  final double totalExpense;
}

class EmptyFilterListState extends BudgetState {}

class OverviewFilterArguments {
  final Map<String, List<TransactionEntity>> groupedExpense;

  OverviewFilterArguments({required this.groupedExpense});

  OverviewFilterArguments copyWith({
    Map<String, List<TransactionEntity>>? groupedExpense,
  }) {
    return OverviewFilterArguments(
      groupedExpense: groupedExpense ?? this.groupedExpense,
    );
  }
}
