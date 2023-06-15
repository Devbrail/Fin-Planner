import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../../../core/enum/filter_expense.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';
import '../../summary/controller/summary_controller.dart';

@injectable
class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit(
    this.getExpensesUseCase,
    this.summaryController,
  ) : super(BudgetInitial());

  final GetExpensesUseCase getExpensesUseCase;
  final SummaryController summaryController;
  List<String> _filterTimes = [];
  Map<String, List<Expense>> _groupedExpenses = {};
  String? selectedTime;

  void fetchBudgetSummary(List<Expense> expenses, FilterExpense filterExpense) {
    _groupedExpenses = groupBy(
        expenses, (Expense expense) => expense.time.formatted(filterExpense));
    final String time = selectedTime = _groupedExpenses.keys.first;
    _filterTimes = _groupedExpenses.keys.toList();
    emit(InitialSelectedState(time, _filterTimes));
    Future.delayed(Duration.zero)
        .then((value) => fetchSelectedTimeExpenses(time));
  }

  void updateFilterTime(String time) {
    selectedTime = time;
    emit(InitialSelectedState(selectedTime!, _filterTimes));
    fetchSelectedTimeExpenses(time);
  }

  void fetchSelectedTimeExpenses(String time) {
    final List<Expense> selectedTimeExpenses = _groupedExpenses[time] ?? [];
    final List<MapEntry<Category, List<Expense>>> categoryGroupedExpenses =
        groupBy(
                selectedTimeExpenses,
                (Expense expense) =>
                    summaryController.getCategory(expense.categoryId)!)
            .entries
            .toList();
    emit(FilteredCategoryListState(
      categoryGroupedExpenses.sorted(
          (a, b) => b.value.totalExpense.compareTo(a.value.totalExpense)),
      selectedTimeExpenses.total,
    ));
  }
}

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {}

class InitialSelectedState extends BudgetState {
  final String selectedTime;
  final List<String> filerTimes;

  const InitialSelectedState(this.selectedTime, this.filerTimes);

  @override
  List<Object> get props => [selectedTime, filerTimes];
}

class FilteredCategoryListState extends BudgetState {
  final List<MapEntry<Category, List<Expense>>> categoryGrouped;
  final double totalExpense;

  const FilteredCategoryListState(this.categoryGrouped, this.totalExpense);
}
