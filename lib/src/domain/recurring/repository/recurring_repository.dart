import '../../../core/enum/recurring_type.dart';

import '../../../core/enum/transaction_type.dart';

abstract class RecurringRepository {
  Future<void> checkForRecurring();

  Future<void> addRecurringEvent(
    String name,
    double amount,
    DateTime recurringTime,
    RecurringType recurringType,
    int selectedAccountId,
    int selectedCategoryId,
    TransactionType transactionType,
  );
}
