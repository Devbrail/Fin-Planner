import 'package:paisa/core/common_enum.dart';

class UpdateAccount {
  final String bankName;
  final String holderName;
  final String number;
  final CardType cardType;
  final double amount;
  final int color;
  final int key;

  UpdateAccount(
    this.key, {
    required this.bankName,
    required this.holderName,
    required this.number,
    required this.cardType,
    required this.amount,
    required this.color,
  });
}
