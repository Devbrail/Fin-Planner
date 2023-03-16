import 'package:injectable/injectable.dart';

import '../../../data/expense/model/expense_model.dart';
import '../repository/expense_repository.dart';

@singleton
class GetExpenseUseCase {
  GetExpenseUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  Future<ExpenseModel?> call(int expenseId) async =>
      expenseRepository.fetchExpenseFromId(expenseId);
}
