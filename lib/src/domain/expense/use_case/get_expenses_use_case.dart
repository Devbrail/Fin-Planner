import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../entities/expense.dart';
import '../repository/expense_repository.dart';

@singleton
class GetExpensesUseCase {
  GetExpensesUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  List<Expense> call() => expenseRepository.expenses().toEntities();
}
