import 'package:injectable/injectable.dart';
import 'package:paisa/features/home/data/data_sources/combined_transaction_manager.dart';
import 'package:paisa/features/home/data/models/combined_transaction.dart';
import 'package:paisa/features/home/domain/repository/combined_transaction_repository.dart';

@Singleton(as: CombinedTransactionRepository)
class CombinedTransactionRepoImpl implements CombinedTransactionRepository {
  final CombinedTransactionManager combinedTransactionManager;

  CombinedTransactionRepoImpl(this.combinedTransactionManager);
  @override
  Future<List<CombinedTransaction>> fetch() {
    return combinedTransactionManager.fetch();
  }
}
