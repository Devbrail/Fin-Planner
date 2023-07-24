import 'package:injectable/injectable.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/home/data/models/combined_transaction.dart';
import 'package:paisa/features/home/domain/repository/combined_transaction_repository.dart';

@singleton
class CombinedTransactionUseCase
    implements UseCase<Future<List<CombinedTransaction>>, NoParams> {
  final CombinedTransactionRepository combinedTransactionRepository;

  CombinedTransactionUseCase(this.combinedTransactionRepository);
  @override
  Future<List<CombinedTransaction>> call({NoParams? params}) {
    return combinedTransactionRepository.fetch();
  }
}
