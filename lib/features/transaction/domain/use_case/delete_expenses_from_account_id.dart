import 'package:injectable/injectable.dart';

import '../repository/expense_repository.dart';

@singleton
class DeleteExpensesFromAccountIdUseCase {
  DeleteExpensesFromAccountIdUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> call(int accountId) async =>
      expenseRepository.deleteExpensesByAccountId(accountId);
}
