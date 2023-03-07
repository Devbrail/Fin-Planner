import 'package:injectable/injectable.dart';

import '../repository/expense_repository.dart';

@injectable
class DeleteExpenseUseCase {
  DeleteExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> call(int expense) async =>
      expenseRepository.clearExpense(expense);
}
