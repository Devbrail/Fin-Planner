import 'package:hive/hive.dart';

import '../../../common/enum/transaction.dart';
import '../../accounts/model/account.dart';
import '../../category/model/category.dart';

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

  @HiveField(5)
  Category category;

  @HiveField(6)
  Account account;

  @HiveField(7, defaultValue: TransactonType.expense)
  TransactonType? type;

  Expense({
    required this.name,
    required this.currency,
    required this.time,
    required this.category,
    required this.account,
    this.addOrSub = false,
    required this.type,
  });
}
