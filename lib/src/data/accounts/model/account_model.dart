import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:paisa/src/core/common.dart';

import '../../../core/enum/card_type.dart';

part 'account_model.g.dart';

@HiveType(typeId: 2)
class AccountModel extends HiveObject with EquatableMixin {
  AccountModel({
    required this.name,
    required this.icon,
    required this.bankName,
    required this.number,
    required this.cardType,
    this.superId,
    required this.amount,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
      name: json["name"],
      bankName: json["bankName"],
      icon: json["icon"],
      number: json["number"],
      cardType: (json["cardType"] as String).type,
      amount: json["amount"])
    ..superId = json["superId"];

  @HiveField(8, defaultValue: 0)
  double? amount;

  @HiveField(3)
  String bankName;

  @HiveField(6, defaultValue: CardType.bank)
  CardType? cardType;

  @HiveField(1)
  int icon;

  @HiveField(0)
  String name;

  @HiveField(5)
  String number;

  @HiveField(7, defaultValue: 0)
  int? superId;

  @override
  List<Object> get props {
    return [
      name,
      icon,
      bankName,
      number,
    ];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'bankName': bankName,
        'icon': icon,
        'number': number,
        'cardType': cardType?.name,
        'superId': superId,
        'amount': amount,
      };

  AccountModel copyWith({
    String? name,
    int? icon,
    String? bankName,
    String? number,
    CardType? cardType,
    int? superId,
    double? amount,
  }) {
    return AccountModel(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      bankName: bankName ?? this.bankName,
      number: number ?? this.number,
      cardType: cardType ?? this.cardType,
      superId: superId ?? this.superId,
      amount: amount ?? this.amount,
    );
  }
}
