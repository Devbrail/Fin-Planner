import 'package:injectable/injectable.dart';
import 'package:paisa/features/transaction/domain/repository/expense_repository.dart';

@singleton
class DeleteExpensesFromCategoryIdUseCase {
  DeleteExpensesFromCategoryIdUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> call(int categoryId) =>
      expenseRepository.deleteExpensesByCategoryId(categoryId);
}
