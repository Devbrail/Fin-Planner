import 'package:injectable/injectable.dart';

import '../repository/debit_repository.dart';

@singleton
class AddTransactionUseCase {
  final DebtRepository debtRepository;

  AddTransactionUseCase({required this.debtRepository});

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
