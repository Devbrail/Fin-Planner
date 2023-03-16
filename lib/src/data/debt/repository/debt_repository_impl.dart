import 'package:injectable/injectable.dart';

import '../../../core/enum/debt_type.dart';
import '../../../domain/debt/repository/debit_repository.dart';
import '../data_sources/debt_local_data_source.dart';
import '../models/debt_model.dart';

@Singleton(as: DebtRepository)
class DebtRepositoryImpl extends DebtRepository {
  final DebtLocalDataSource dataSource;

  DebtRepositoryImpl({required this.dataSource});
  @override
  Future<void> addDebtOrCredit(
    String description,
    String name,
    double amount,
    DateTime currentDateTime,
    DateTime dueDateTime,
    DebtType debtType,
  ) async {
    await dataSource.addDebtOrCredit(
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
  Future<DebtModel?> fetchDebtOrCreditFromId(int debtId) =>
      dataSource.fetchDebtOrCreditFromId(debtId);
}
