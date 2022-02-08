import 'package:hive/hive.dart';

import '../../../common/enum/transaction.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double currency;

  @HiveField(3)
  bool addOrSub;

  @HiveField(4)
  DateTime time;

  @HiveField(7, defaultValue: TransactonType.expense)
  TransactonType? type;

  /* @HiveField(5)
  Category category; */

  /* @HiveField(6)
  Account account; */

  @HiveField(8)
  int accountId;

  @HiveField(9)
  int categoryId;

  @HiveField(10)
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
