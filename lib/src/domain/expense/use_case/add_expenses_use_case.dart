import 'package:flutter_paisa/src/core/enum/transaction.dart';
import 'package:flutter_paisa/src/domain/expense/repository/expense_repository.dart';

class AddExpenseUseCase {
  AddExpenseUseCase(
    this.expenseRepository,
  );

  final ExpenseRepository expenseRepository;

  Future<void> execute({
    required String name,
    required double amount,
    required DateTime time,
    required int categoryId,
    required int accountId,
    required TransactionType transactionType,
  }) =>
      expenseRepository.addExpense(
        name,
        amount,
        time,
        categoryId,
        accountId,
        transactionType,
      );
}
