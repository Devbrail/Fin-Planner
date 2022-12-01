import '../repository/expense_repository.dart';

class DeleteExpenseUseCase {
  DeleteExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> execute(int expense) async =>
      expenseRepository.clearExpense(expense);
}
