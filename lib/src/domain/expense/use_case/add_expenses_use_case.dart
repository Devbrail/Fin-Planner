import 'package:flutter_paisa/src/core/enum/transaction.dart';
import 'package:flutter_paisa/src/domain/expense/repository/expense_repository.dart';

class AddExpenseUseCase {
  AddExpenseUseCase(
    this.expenseRepository,
  );

  final ExpenseRepository expenseRepository;

  Future<void> execute(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactionType type,
  ) =>
      expenseRepository.addExpense(
        name,
        amount,
        time,
        category,
        account,
        type,
      );
}
