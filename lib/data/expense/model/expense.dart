import 'package:hive/hive.dart';

import '../../../common/enum/transaction.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double currency;

  @HiveField(2)
  bool addOrSub;

  @HiveField(3)
  DateTime time;

  @HiveField(4, defaultValue: TransactonType.expense)
  TransactonType? type;

  @HiveField(5)
  int accountId;

  @HiveField(6)
  int categoryId;

  @HiveField(7)
  int? superId;

  Expense({
    required this.name,
    required this.currency,
    required this.time,
    required this.categoryId,
    required this.accountId,
    this.addOrSub = false,
    required this.type,
  });
}
