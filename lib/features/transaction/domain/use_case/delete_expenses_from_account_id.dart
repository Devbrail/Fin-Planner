import 'package:injectable/injectable.dart';
import 'package:paisa/features/transaction/domain/repository/expense_repository.dart';

@singleton
class DeleteExpensesFromAccountIdUseCase {
  DeleteExpensesFromAccountIdUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> call(int accountId) async =>
      expenseRepository.deleteExpensesByAccountId(accountId);
}
