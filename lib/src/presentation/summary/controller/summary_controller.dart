import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../../data/expense/model/expense.dart';

@singleton
class SummaryController {
  final Box<Expense> expenseBox;

  SummaryController(this.expenseBox);
}
