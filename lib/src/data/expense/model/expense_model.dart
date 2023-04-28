import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/common.dart';
import '../../../core/enum/transaction.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject with EquatableMixin {
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

  @HiveField(8)
  String? description;

  @HiveField(9)
  int? fromAccountId;

  @HiveField(10)
  int? toAccountId;

  @HiveField(11, defaultValue: 0.0)
  double transferAmount;

  ExpenseModel({
    required this.name,
    required this.currency,
    required this.time,
    required this.categoryId,
    required this.accountId,
    required this.type,
    this.description,
    this.superId,
    this.fromAccountId,
    this.toAccountId,
    this.transferAmount = 0.0,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'currency': currency,
        'time': time.toIso8601String(),
        'type': type?.type,
        'accountId': accountId,
        'categoryId': categoryId,
        'superId': superId,
        'description': description,
        'fromAccountId': fromAccountId,
        'toAccountId': toAccountId,
        'transferAmount': transferAmount,
      };

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
      name: json['name'],
      currency: json['currency'],
      time: DateTime.parse(json['time']),
      categoryId: json['categoryId'],
      accountId: json['accountId'],
      type: (json['type'] as String).transactionType,
      description: (json['description'] as String),
      fromAccountId: json['fromAccountId'],
      toAccountId: json['toAccountId'],
      transferAmount: json['transferAmount'])
    ..superId = json['superId'];

  @override
  List<Object?> get props => [name, type];
}
