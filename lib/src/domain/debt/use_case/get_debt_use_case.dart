import 'package:injectable/injectable.dart';

import '../entities/debt.dart';
import '../repository/debit_repository.dart';

@singleton
class GetDebtUseCase {
  GetDebtUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  Debt? call(int debtId) =>
      debtRepository.fetchDebtOrCreditFromId(debtId)?.toEntity();
}
