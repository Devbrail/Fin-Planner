import 'package:injectable/injectable.dart';

import '../../../core/enum/transaction_type.dart';
import '../entities/expense.dart';
import '../repository/expense_repository.dart';

@singleton
class UpdateExpensesUseCase {
  UpdateExpensesUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> call(Expense expense) {
    return expenseRepository.updateExpense(
      expense.superId!,
      expense.name,
      expense.currency,
      expense.time,
      expense.categoryId,
      expense.accountId,
      expense.type ?? TransactionType.expense,
      expense.description,
    );
  }
}
