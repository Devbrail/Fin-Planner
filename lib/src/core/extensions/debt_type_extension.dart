import 'package:flutter/material.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/core/enum/debt_type.dart';

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
