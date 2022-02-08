import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../common/constants/currency.dart';
import '../../../common/enum/transaction.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../data/expense/model/expense.dart';
import 'total_text_widget.dart';

class ExpenseTotalWidget extends StatelessWidget {
  const ExpenseTotalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: Hive.box<Expense>('expense').listenable(),
      builder: (BuildContext context, value, Widget? child) {
        final expenses = value.values.toList();
        final totalIncome = _expensesTotal(expenses, TransactonType.income);
        final totalExpense = _expensesTotal(expenses, TransactonType.expense);
        final totalDeposit = _expensesTotal(expenses, TransactonType.deposit);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                AppLocalizations.of(context)!.total,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: MaterialYouCard(
                child: SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TotalTextWidget(
                          title: TransactonType.income.name(context),
                          value: totalIncome,
                        ),
                        const SizedBox(height: 16),
                        TotalTextWidget(
                          title: TransactonType.expense.name(context),
                          value: totalExpense,
                        ),
                        const SizedBox(height: 16),
                        TotalTextWidget(
                          title: TransactonType.deposit.name(context),
                          value: totalDeposit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

String _expensesTotal(
  List<Expense> expenses,
  TransactonType type,
) {
  final total = expenses
      .where((element) => _filterWithDays(element, type: type))
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);
  return getTwoDigitCurrency(total);
}

bool _filterWithDays(
  Expense expense, {
  TransactonType type = TransactonType.expense,
}) =>
    expense.type == type;
