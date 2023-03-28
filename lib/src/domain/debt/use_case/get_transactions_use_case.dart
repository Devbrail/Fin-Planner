import 'package:injectable/injectable.dart';

import '../../../core/extensions/transaction_extension.dart';
import '../entities/transaction.dart';
import '../repository/debit_repository.dart';

@singleton
class GetTransactionsUseCase {
  final DebtRepository debtRepository;

  GetTransactionsUseCase({required this.debtRepository});

  List<Transaction> call(int id) =>
      debtRepository.fetchTransactionsFromId(id).toEntities();
}
