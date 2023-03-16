import 'package:paisa/src/data/accounts/model/account_model.dart';

class Account extends AccountModel {
  Account({
    required super.name,
    required super.icon,
    required super.bankName,
    required super.number,
    required super.cardType,
    required super.amount,
    super.superId,
  });
}
