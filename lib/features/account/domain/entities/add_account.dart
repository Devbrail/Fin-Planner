import 'package:paisa/core/common_enum.dart';

class AddAccount {
  final String bankName;
  final String holderName;
  final String number;
  final CardType cardType;
  final double amount;
  final int color;
  AddAccount({
    required this.bankName,
    required this.holderName,
    required this.number,
    required this.cardType,
    required this.amount,
    required this.color,
  });
}
