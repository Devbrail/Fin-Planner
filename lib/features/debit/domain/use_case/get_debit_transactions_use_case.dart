import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/features/debit/domain/entities/debit_transaction.dart';
import 'package:paisa/features/debit/domain/repository/debit_repository.dart';

@singleton
class GetTransactionsUseCase {
  GetTransactionsUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  List<DebitTransaction> call(int id) =>
      debtRepository.fetchTransactionsFromId(id).toEntities();
}
