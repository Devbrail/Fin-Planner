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
  int? superId;

  Account({
    required this.name,
    required this.icon,
    required this.bankName,
    required this.validThru,
    required this.number,
    required this.cardType,
    this.isPredefined = false,
  });

  @override
  List<Object?> get props => [name, icon, bankName];
}
