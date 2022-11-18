import 'package:intl/intl.dart';

import '../../data/expense/model/expense.dart';
import '../../main.dart';

String getCurrency() {
  var format = NumberFormat.simpleCurrency(locale: 'en_IN');
  return format.currencySymbol;
}

String formattedCurrency(double currency, {int? decimalDigits = 2}) {
  return NumberFormat.simpleCurrency(
    locale: currentLocale.toString(),
    decimalDigits: decimalDigits,
  ).format(currency);
}

String totalExpenseWithSymbol(List<Expense> expenses) {
  final total = expenses
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);
  return formattedCurrency(total);
}
