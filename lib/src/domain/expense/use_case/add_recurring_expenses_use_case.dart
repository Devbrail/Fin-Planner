import 'package:injectable/injectable.dart';
import 'package:paisa/src/core/enum/recurring_type.dart';

import '../../../core/enum/transaction.dart';
import '../repository/expense_repository.dart';

@singleton
class AddRecurringExpenseUseCase {
  AddRecurringExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<void> call({
    required String name,
    required double amount,
    required DateTime time,
    required int categoryId,
    required int accountId,
    required TransactionType transactionType,
    String? description,
    RecurringType recurringType = RecurringType.daily,
  }) {
    return expenseRepository.addRecurringExpense(
      name,
      amount,
      time,
      categoryId,
      accountId,
      transactionType,
      description,
      recurringType,
    );
  }
}
