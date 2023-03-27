import 'package:injectable/injectable.dart';

import '../entities/debt.dart';
import '../repository/debit_repository.dart';

@singleton
class UpdateDebtUseCase {
  final DebtRepository debtRepository;

  UpdateDebtUseCase({required this.debtRepository});

  Future<void> call(Debt debt) {
    return debtRepository.updateDebt(
      description: debt.description,
      name: debt.name,
      amount: debt.amount,
      currentDateTime: debt.dateTime,
      dueDateTime: debt.expiryDateTime,
      debtType: debt.debtType,
      key: debt.superId!,
    );
  }
}
