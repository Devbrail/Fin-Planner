import 'package:workmanager/workmanager.dart';

import '../../../main.dart';
import '../../core/enum/transaction.dart';
import '../../data/expense/data_sources/expense_manager_local_data_source.dart';
import '../../data/expense/model/expense.dart';

const String periodicTaskName = 'com.hemanth.dev.periodicTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == periodicTaskName) {
      final storage = getIt.get<LocalExpenseManagerDataSource>();
      await storage.addOrUpdateExpense(Expense(
        name: 'Background expense name 1',
        currency: 320435,
        time: DateTime.now(),
        categoryId: 0,
        accountId: 0,
        type: TransactionType.expense,
      ));
    }
    return Future.value(true);
  });
}
