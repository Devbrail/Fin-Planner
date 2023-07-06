import 'package:injectable/injectable.dart';

import '../../../core/extensions/expense_extensions.dart';
import '../entities/expense.dart';
import '../repository/expense_repository.dart';

@singleton
class GetExpenseUseCase {
  GetExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<Expense?> call(int expenseId) async =>
      expenseRepository.fetchExpenseFromId(expenseId)?.toEntity();
}
