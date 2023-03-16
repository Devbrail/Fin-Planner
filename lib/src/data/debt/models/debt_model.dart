import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/domain/debt/entities/debt.dart';

import '../../../core/enum/debt_type.dart';

part 'debt_model.g.dart';

@HiveType(typeId: 4)
class DebtModel extends HiveObject with EquatableMixin {
  @HiveField(1)
  String description;

  @HiveField(7, defaultValue: '')
  String name;

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime dateTime;

  @HiveField(4)
  DateTime expiryDateTime;

  @HiveField(5, defaultValue: DebtType.debt)
  DebtType debtType;

  @HiveField(6, defaultValue: 0)
  int? superId;

  DebtModel({
    required this.description,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.expiryDateTime,
    required this.debtType,
    this.superId,
  });

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
