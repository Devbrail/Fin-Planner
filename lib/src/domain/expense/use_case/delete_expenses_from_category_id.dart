import 'package:injectable/injectable.dart';

import '../repository/expense_repository.dart';

@singleton
class DeleteExpensesFromCategoryIdUseCase {
  DeleteExpensesFromCategoryIdUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> call(int categoryId) =>
      expenseRepository.deleteExpensesByCategoryId(categoryId);
}
