import 'package:injectable/injectable.dart';

import '../../../data/expense/model/expense_model.dart';
import '../repository/expense_repository.dart';

@singleton
class GetExpensesUseCase {
  GetExpensesUseCase({required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  List<ExpenseModel> call() => expenseRepository.expenses();
}
