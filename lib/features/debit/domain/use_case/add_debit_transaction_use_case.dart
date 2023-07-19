import 'package:injectable/injectable.dart';

import '../repository/debit_repository.dart';

@singleton
class AddTransactionUseCase {
  AddTransactionUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  Future<void> call({
    required double amount,
    required DateTime currentDateTime,
    required int parentId,
  }) {
    return debtRepository.addTransaction(
      amount,
      currentDateTime,
      parentId,
    );
  }
}
