import 'package:injectable/injectable.dart';
import 'package:paisa/features/transaction/domain/repository/expense_repository.dart';

@singleton
class DeleteExpenseUseCase {
  DeleteExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> call(int expense) async =>
      expenseRepository.clearExpense(expense);
}
