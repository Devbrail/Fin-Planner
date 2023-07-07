import 'package:flutter/material.dart';

import '../../../core/enum/card_type.dart';
import '../model/account_model.dart';

List<AccountModel> defaultAccountsData() {
  return [
    AccountModel(
      name: 'User name',
      bankName: 'Cash',
      number: '',
      cardType: CardType.cash,
      amount: 0.0,
      color: Colors.primaries[0].value,
    ),
    AccountModel(
      name: 'User name',
      bankName: 'Bank',
      number: '',
      cardType: CardType.bank,
      amount: 0.0,
      color: Colors.primaries[1].value,
    ),
    AccountModel(
      name: 'User name',
      bankName: 'Wallet',
      number: '',
      cardType: CardType.wallet,
      amount: 0.0,
      color: Colors.primaries[2].value,
    ),
  ];
}
