import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../core/enum/card_type.dart';

part 'account_model.g.dart';

@HiveType(typeId: 2)
class AccountModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  String name;

  @HiveField(1)
  int icon;

  @HiveField(3)
  String bankName;

  @HiveField(5)
  String number;

  @HiveField(6, defaultValue: CardType.bank)
  CardType? cardType;

  @HiveField(7, defaultValue: 0)
  int? superId;

  @HiveField(8, defaultValue: 0)
  double? amount;

  AccountModel({
    required this.name,
    required this.icon,
    required this.bankName,
    required this.number,
    required this.cardType,
    required this.amount,
    this.superId,
  });

  @override
  List<Object?> get props => [name, icon, bankName];

  Map<String, dynamic> toJson() => {
        'name': name,
        'bankName': bankName,
        'icon': icon,
        'number': number,
        'cardType': cardType?.name,
        'superId': superId,
        'amount': amount,
      };

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
      name: json["name"],
      bankName: json["bankName"],
      icon: json["icon"],
      number: json["number"],
      cardType: (json["cardType"] as String).type,
      amount: json["amount"])
    ..superId = json["superId"];
}
