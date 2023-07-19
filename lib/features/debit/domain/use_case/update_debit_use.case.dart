import 'package:injectable/injectable.dart';
import 'package:paisa/features/debit/domain/entities/debit.dart';
import 'package:paisa/features/debit/domain/repository/debit_repository.dart';

@singleton
class UpdateDebtUseCase {
  UpdateDebtUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  Future<void> call(Debit debt) {
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
