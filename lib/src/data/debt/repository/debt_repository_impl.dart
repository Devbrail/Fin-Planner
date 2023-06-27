import 'package:injectable/injectable.dart';

import '../../../core/enum/debt_type.dart';
import '../../../domain/debt/repository/debit_repository.dart';
import '../data_sources/debt_local_data_source.dart';
import '../models/debt_model.dart';
import '../models/transactions_model.dart';

@Singleton(as: DebtRepository)
class DebtRepositoryImpl extends DebtRepository {
  DebtRepositoryImpl({required this.dataSource});

  final DebtLocalDataSource dataSource;

  @override
  Future<void> addDebtOrCredit(
    String description,
    String name,
    double amount,
    DateTime currentDateTime,
    DateTime dueDateTime,
    DebtType debtType,
  ) {
    return dataSource.addDebtOrCredit(
      DebtModel(
        description: description,
        amount: amount,
        dateTime: currentDateTime,
        expiryDateTime: dueDateTime,
        debtType: debtType,
        name: name,
      ),
    );
  }

  @override
  Future<void> addTransaction(
    double amount,
    DateTime currentDateTime,
    int parentId,
  ) {
    return dataSource.addTransaction(TransactionsModel(
      amount: amount,
      now: currentDateTime,
      parentId: parentId,
    ));
  }

  @override
  Future<void> deleteDebtOrCreditFromId(int debtId) {
    return dataSource.deleteDebtOrCreditFromId(debtId);
  }

  @override
  Future<void> deleteTransactionFromId(int transactionId) {
    return dataSource.deleteTransactionFromId(transactionId);
  }

  @override
  Future<void> deleteTransactionsFromId(int parentId) {
    return dataSource.deleteTransactionsFromId(parentId);
  }

  @override
  DebtModel? fetchDebtOrCreditFromId(int debtId) =>
      dataSource.fetchDebtOrCreditFromId(debtId);

  @override
  Iterable<TransactionsModel> fetchTransactionsFromId(int id) {
    return dataSource.getTransactionsFromId(id);
  }

  @override
  Future<void> updateDebt({
    required String description,
    required String name,
    required double amount,
    required DateTime currentDateTime,
    required DateTime dueDateTime,
    required DebtType debtType,
    required int key,
  }) {
    return dataSource.updateDebt(DebtModel(
      description: description,
      name: name,
      amount: amount,
      dateTime: currentDateTime,
      expiryDateTime: dueDateTime,
      debtType: debtType,
      superId: key,
    ));
  }
}
