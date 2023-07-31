import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';

class CombineRequest {
  final List<AccountEntity> accounts;
  final List<CategoryEntity> categories;
  final List<TransactionEntity> transactions;

  CombineRequest(
    this.accounts,
    this.categories,
    this.transactions,
  );
}
