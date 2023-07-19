import 'package:paisa/features/account/data/model/account_model.dart';

class Account extends AccountModel {
  Account({
    required super.name,
    required super.bankName,
    required super.number,
    required super.cardType,
    required super.amount,
    required super.color,
    super.superId,
  });
}
