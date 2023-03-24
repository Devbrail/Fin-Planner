import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../main.dart';
import '../../../../core/common.dart';
import '../../../../data/expense/model/expense_model.dart';
import '../../../../domain/expense/entities/expense.dart';
import '../../../widgets/paisa_empty_widget.dart';
import '../../widgets/filter_date_range_widget.dart';
import 'budget_overview_page_v2.dart';

class BudgetOverViewPage extends StatelessWidget {
  const BudgetOverViewPage({
    Key? key,
    required this.dateTimeRangeNotifier,
  }) : super(key: key);

  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ExpenseModel>>(
      valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
      builder: (context, value, _) {
        final List<Expense> expenses = value.budgetOverView.toEntities();
        if (expenses.isEmpty) {
          return EmptyWidget(
            icon: Icons.paid,
            title: context.loc.errorNoBudgetLabel,
            description: context.loc.errorNoBudgetDescriptionLabel,
          );
        }
        return FilterDateRangeWidget(
          dateTimeRangeNotifier: dateTimeRangeNotifier,
          expenses: expenses,
          builder: (expenses) => BudgetOverviewPageV2(expenses: expenses),
        );
      },
    );
  }
}
