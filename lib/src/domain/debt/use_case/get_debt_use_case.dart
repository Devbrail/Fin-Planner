import 'package:injectable/injectable.dart';

import '../entities/debt.dart';
import '../repository/debit_repository.dart';

@singleton
class GetDebtUseCase {
  final DebtRepository debtRepository;

  GetDebtUseCase({required this.debtRepository});

  Debt? call(int debtId) =>
      debtRepository.fetchDebtOrCreditFromId(debtId)?.toEntity();
}
