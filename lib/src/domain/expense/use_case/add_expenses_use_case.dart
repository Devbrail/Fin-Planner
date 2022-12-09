import '../../../core/enum/transaction.dart';
import '../repository/expense_repository.dart';

class AddExpenseUseCase {
  AddExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> call({
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
