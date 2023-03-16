import 'package:workmanager/workmanager.dart';

import '../../../main.dart';
import '../../core/enum/transaction.dart';
import '../../data/expense/data_sources/local_expense_data_manager.dart';
import '../../data/expense/model/expense_model.dart';

const String periodicTaskName = 'com.hemanth.dev.periodicTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == periodicTaskName) {
      final storage = getIt.get<LocalExpenseDataManager>();
      await storage.addOrUpdateExpense(ExpenseModel(
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
