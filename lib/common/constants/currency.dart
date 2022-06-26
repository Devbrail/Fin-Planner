import 'package:intl/intl.dart';

import '../../data/expense/model/expense.dart';
import '../../main.dart';

String getCurrency() {
  var format = NumberFormat.simpleCurrency(locale: 'en_IN');
  return format.currencySymbol;
}

String formattedCurrency(double currency) {
  return NumberFormat.simpleCurrency(
    locale: currentLocale.toString(),
    decimalDigits: 2,
  ).format(currency);
}

String getTwoDigitCurrency(double currency) {
  return NumberFormat.simpleCurrency(
    locale: currentLocale.toString(),
  ).format(currency);
}

String totalExpenseWithSymbol(List<Expense> expenses) {
  final total = expenses
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);
  return formattedCurrency(total);
}

double totalExpense(List<Expense> expenses) {
  final total = expenses
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);
  return total;
}
