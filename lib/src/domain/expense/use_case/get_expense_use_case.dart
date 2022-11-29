import '../../../data/expense/model/expense.dart';
import '../repository/expense_repository.dart';

class GetExpenseUseCase {
  GetExpenseUseCase(this.expenseRepository);

  final ExpenseRepository expenseRepository;

  Future<Expense?> execute(int expenseId) async =>
      expenseRepository.fetchExpenseFromId(expenseId);
}
