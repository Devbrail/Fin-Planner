import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/enum/debt_type.dart';
import '../../../domain/debt/entities/debt.dart';

part 'debt_model.g.dart';

@HiveType(typeId: 4)
class DebtModel extends HiveObject with EquatableMixin {
  DebtModel({
    required this.description,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.expiryDateTime,
    required this.debtType,
    this.superId,
  });

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime dateTime;

  @HiveField(5, defaultValue: DebtType.debt)
  DebtType debtType;

  @HiveField(1)
  String description;

  @HiveField(4)
  DateTime expiryDateTime;

  @HiveField(7, defaultValue: '')
  String name;

  @HiveField(6, defaultValue: 0)
  int? superId;

  @override
  List<Object?> get props => [
        description,
        amount,
        name,
        dateTime,
        expiryDateTime,
        debtType,
      ];

  Debt toEntity() => Debt(
        description: description,
        name: name,
        amount: amount,
        dateTime: dateTime,
        expiryDateTime: expiryDateTime,
        debtType: debtType,
        superId: superId,
      );
}
