import 'package:injectable/injectable.dart';
import 'package:paisa/src/core/common.dart';

import '../entities/expense.dart';
import '../repository/expense_repository.dart';

@singleton
class GetExpensesFromAccountIdUseCase {
  GetExpensesFromAccountIdUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  List<Expense> call(int accountId) =>
      expenseRepository.fetchExpensesFromAccountId(accountId).toEntities();
}
