import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../common/enum/card_type.dart';

part 'account.g.dart';

@HiveType(typeId: 2)
class Account extends HiveObject with EquatableMixin {
  @HiveField(0)
  String name;

  @HiveField(1)
  int icon;

  @HiveField(2)
  bool isPredefined;

  @HiveField(3)
  String bankName;

  @HiveField(4)
  DateTime validThru;

  @HiveField(5)
  String number;

  @HiveField(6, defaultValue: CardType.debitcard)
  CardType? cardType;

  @HiveField(7, defaultValue: 0)
  String superId;

  Account({
    required this.name,
    required this.icon,
    required this.bankName,
    required this.validThru,
    required this.number,
    required this.cardType,
    this.isPredefined = false,
    required this.superId,
  });

  @override
  List<Object?> get props => [name, icon, bankName];

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        name: json['name'],
        icon: json['icon'],
        bankName: json['bankName'],
        validThru: DateTime.fromMicrosecondsSinceEpoch(json['validThru']),
        number: json['number'],
        cardType: json['cardType'].toString().type,
        superId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'validThru': validThru.millisecondsSinceEpoch,
        'icon': icon,
        'cardType': cardType!.name,
        'bankName': bankName,
        'number': number,
        'id': superId,
      };
}
