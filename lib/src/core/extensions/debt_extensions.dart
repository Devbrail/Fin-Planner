import 'package:flutter/material.dart';

import '../../data/debt/models/debt_model.dart';
import '../../domain/debt/entities/debt.dart';
import '../common.dart';
import '../enum/debt_type.dart';

extension DebtTypeHelper on DebtType {
  String stringValue(BuildContext context) {
    switch (this) {
      case DebtType.debt:
        return context.loc.debt;
      case DebtType.credit:
        return context.loc.credit;
    }
  }
}

extension AccountMapping on DebtModel {
  Debt toEntity() {
    return Debt(
      description: description,
      name: name,
      amount: amount,
      dateTime: dateTime,
      expiryDateTime: expiryDateTime,
      debtType: debtType,
      superId: superId,
    );
  }
}
