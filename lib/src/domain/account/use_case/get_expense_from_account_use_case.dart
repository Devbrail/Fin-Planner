import 'package:injectable/injectable.dart';

import '../../../data/expense/model/expense.dart';
import '../repository/account_repository.dart';

@singleton
class GetExpensesFromAccountUseCase {
  final AccountRepository accountRepository;

  GetExpensesFromAccountUseCase({required this.accountRepository});

  List<Expense> call(int accountId) =>
      accountRepository.fetchExpensesFromAccountId(accountId);
}
