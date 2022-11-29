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
  DateTime time;

  @HiveField(4, defaultValue: TransactionType.expense)
  TransactionType? type;

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
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'currency': currency,
        'time': time.toIso8601String(),
        'type': type?.nameString,
        'accountId': accountId,
        'categoryId': categoryId,
        'superId': superId,
      };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        name: json['name'],
        currency: json['currency'],
        time: DateTime.parse(json['time']),
        categoryId: json['categoryId'],
        accountId: json['accountId'],
        type: (json['type'] as String).type,
      )..superId = json['superId'];
}
