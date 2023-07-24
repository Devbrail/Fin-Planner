import 'package:paisa/features/home/data/models/combined_transaction.dart';

abstract class CombinedTransactionRepository {
  Future<List<CombinedTransaction>> fetch();
}
