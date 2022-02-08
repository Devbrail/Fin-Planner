import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../common/constants/currency.dart';
import '../../../common/constants/time.dart';
import '../../../common/enum/filter_days.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../data/expense/model/expense.dart';
import 'total_text_widget.dart';

class ExpenseSummaryWidget extends StatelessWidget {
  const ExpenseSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: Hive.box<Expense>('expense').listenable(),
      builder: (BuildContext context, value, Widget? child) {
        final expenses = value.values.toList();
        final yesterday = _expensesTotal(expenses, FilterDays.yesterday);
        final lastSevenDays = _expensesTotal(expenses, FilterDays.seven);
        final lastThirtyDays = _expensesTotal(expenses, FilterDays.thirty);
        return Padding(
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
                      title: AppLocalizations.of(context)!.yesterday,
                      value: yesterday,
                    ),
                    const SizedBox(height: 16),
                    TotalTextWidget(
                      title: AppLocalizations.of(context)!.lastSeventDays,
                      value: lastSevenDays,
                    ),
                    const SizedBox(height: 16),
                    TotalTextWidget(
                      title: AppLocalizations.of(context)!.lastThirtyDays,
                      value: lastThirtyDays,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String _expensesTotal(
  List<Expense> expenses,
  FilterDays filterDays,
) {
  final total = expenses
      .where((element) => _filterWithDays(element, filterDays: filterDays))
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + element);
  return getTwoDigitCurrency(total);
}

bool _filterWithDays(
  Expense expense, {
  FilterDays filterDays = FilterDays.yesterday,
}) {
  final int days = expense.time.daysDifference;
  return filterDays.filterDate(days);
}
