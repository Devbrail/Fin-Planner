import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';

import '../repository/debit_repository.dart';

@singleton
class DeleteTransactionUseCase implements UseCase<Future<void>, int> {
  DeleteTransactionUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  @override
  Future<void> call({int? params}) {
    return debtRepository.deleteTransactionFromId(params!);
  }
}
