import 'package:injectable/injectable.dart';

import '../entities/expense.dart';
import '../repository/expense_repository.dart';
import '../../../core/extensions/expense_extensions.dart';

@singleton
class GetExpenseUseCase {
  GetExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<Expense?> call(int expenseId) async =>
      expenseRepository.fetchExpenseFromId(expenseId)?.toEntity();
}
