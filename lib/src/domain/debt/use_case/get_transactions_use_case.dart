import 'package:injectable/injectable.dart';

import '../../../core/extensions/transaction_extension.dart';
import '../entities/transaction.dart';
import '../repository/debit_repository.dart';

@singleton
class GetTransactionsUseCase {
  GetTransactionsUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  List<Transaction> call(int id) =>
      debtRepository.fetchTransactionsFromId(id).toEntities();
}
