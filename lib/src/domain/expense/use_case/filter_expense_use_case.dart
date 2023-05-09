import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../entities/expense.dart';
import '../repository/expense_repository.dart';

@singleton
class FilterExpenseUseCase {
  FilterExpenseUseCase(this.expenseRepository);

  final ExpenseRepository expenseRepository;

  List<Expense> call(
    String query,
    int? accountId,
    int? categoryId,
  ) {
    return expenseRepository
        .filterExpenses(query, accountId, categoryId)
        .toEntities();
  }
}
