import 'package:injectable/injectable.dart';

import '../../../core/enum/transaction.dart';
import '../repository/expense_repository.dart';

@singleton
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
    required String? description,
  }) =>
      expenseRepository.addExpense(
        name,
        amount,
        time,
        categoryId,
        accountId,
        transactionType,
        description,
      );
}
