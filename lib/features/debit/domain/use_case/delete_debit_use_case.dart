import 'package:injectable/injectable.dart';
import 'package:paisa/features/debit/domain/repository/debit_repository.dart';

@singleton
class DeleteDebtUseCase {
  DeleteDebtUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  Future<void> call(int debtId) {
    return debtRepository.deleteDebtOrCreditFromId(debtId);
  }
}
