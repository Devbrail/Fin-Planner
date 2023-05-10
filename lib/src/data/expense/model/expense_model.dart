import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/common.dart';
import '../../../core/enum/recurring_type.dart';
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

  @HiveField(14)
  RecurringType? recurringType;

  @HiveField(13)
  DateTime? recurringDate;

  ExpenseModel({
    required this.name,
    required this.currency,
    required this.time,
    required this.type,
    required this.accountId,
    required this.categoryId,
    this.superId,
    this.description,
    this.fromAccountId,
    this.toAccountId,
    this.transferAmount = 0.0,
    this.recurringType,
    this.recurringDate,
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
        "recurringType": recurringType?.index,
        "recurringDate": recurringDate,
      };

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        name: json['name'],
        currency: json['currency'],
        time: DateTime.parse(json['time']),
        categoryId: json['categoryId'],
        accountId: json['accountId'],
        type: (json['type'] as String).transactionType,
        description: json['description'],
        fromAccountId: json['fromAccountId'],
        toAccountId: json['toAccountId'],
        transferAmount: json['transferAmount'],
        recurringDate: DateTime.tryParse(json['recurringDate'] ?? ''),
        recurringType: RecurringType.values[json['recurringType'] ?? 1],
      )..superId = json['superId'];

  @override
  List<Object?> get props {
    return [
      name,
      currency,
      time,
      type,
      accountId,
      categoryId,
      transferAmount,
    ];
  }

  ExpenseModel copyWith({
    String? name,
    double? currency,
    DateTime? time,
    TransactionType? type,
    int? accountId,
    int? categoryId,
    int? superId,
    String? description,
    int? fromAccountId,
    int? toAccountId,
    double? transferAmount,
    RecurringType? recurringType,
    DateTime? recurringDate,
  }) {
    return ExpenseModel(
      name: name ?? this.name,
      currency: currency ?? this.currency,
      time: time ?? this.time,
      type: type ?? this.type,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      superId: superId ?? this.superId,
      description: description ?? this.description,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      toAccountId: toAccountId ?? this.toAccountId,
      transferAmount: transferAmount ?? this.transferAmount,
      recurringType: recurringType ?? this.recurringType,
      recurringDate: recurringDate ?? this.recurringDate,
    );
  }
}
