import 'package:hive/hive.dart';

import '../../../common/enum/box_types.dart';
import '../model/expense.dart';
import 'expense_manager_data_source.dart';

class ExpenseManagerLocalDataSource implements ExpenseManagerDataSource {
  late final epenseBox = Hive.box<Expense>(BoxType.expense.stringValue);
  @override
  Future<void> addOrUpdateExpense(Expense expense) async {
    if (epenseBox.containsKey(expense.key)) {
      await epenseBox.put(expense.key, expense);
    } else {
      await epenseBox.add(expense);
    }
  }

  @override
  Future<List<Expense>> expenses() async {
    return epenseBox.values.toList();
  }

  @override
  Future<void> clearExpenses() async {
    await epenseBox.clear();
  }

  @override
  Future<void> clearExpense(int key) async {
    await epenseBox.delete(key);
  }
}
