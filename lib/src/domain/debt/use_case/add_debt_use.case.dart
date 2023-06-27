import 'package:injectable/injectable.dart';

import '../../../core/enum/debt_type.dart';
import '../repository/debit_repository.dart';

@singleton
class AddDebtUseCase {
  AddDebtUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  Future<void> call({
    required String description,
    required String name,
    required double amount,
    required DateTime currentDateTime,
    required DateTime dueDateTime,
    required DebtType debtType,
  }) {
    return debtRepository.addDebtOrCredit(
      description,
      name,
      amount,
      currentDateTime,
      dueDateTime,
      debtType,
    );
  }
}
