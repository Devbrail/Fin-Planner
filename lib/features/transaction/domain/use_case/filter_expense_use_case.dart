import 'package:injectable/injectable.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/enum/transaction_type.dart';
import 'package:paisa/features/transaction/domain/entities/expense.dart';
import 'package:paisa/features/transaction/domain/repository/expense_repository.dart';

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
