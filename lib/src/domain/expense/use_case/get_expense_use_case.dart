import 'package:injectable/injectable.dart';

import '../../../data/expense/model/expense.dart';
import '../repository/expense_repository.dart';

@singleton
class GetExpenseUseCase {
  GetExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<Expense?> call(int expenseId) async =>
      expenseRepository.fetchExpenseFromId(expenseId);
}
