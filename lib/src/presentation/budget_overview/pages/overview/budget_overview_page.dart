import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/src/domain/expense/entities/expense.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../main.dart';
import '../../../../core/common.dart';
import '../../../../data/category/data_sources/category_local_data_source.dart';
import '../../../../data/expense/model/expense_model.dart';
import '../../../widgets/filter_widget/paisa_filter_transaction_widget.dart';
import '../../../widgets/paisa_empty_widget.dart';
import '../../widgets/budget_section_widget.dart';
import '../../widgets/filter_budget_widget.dart';
import '../../widgets/filter_date_range_widget.dart';
import 'budget_overview_mobile_page.dart';
import 'budget_overview_tablet_page.dart';

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
        List<Expense> expenses =
            value.budgetOverView.map((e) => e.toEntity()).toList();
        if (expenses.isEmpty) {
          return EmptyWidget(
            icon: Icons.paid,
            title: context.loc.errorNoBudgetLabel,
            description: context.loc.errorNoBudgetDescriptionLabel,
          );
        }
        final child = FilterDateRangeWidget(
          dateTimeRangeNotifier: dateTimeRangeNotifier,
          expenses: expenses,
          builder: (List<Expense> expenses) => FilterBudgetWidget(
            valueNotifier: valueNotifier,
            expenses: expenses,
            builder: (filteredBudger) => ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 128),
              itemCount: filteredBudger.length,
              itemBuilder: (BuildContext context, int index) => BudgetSection(
                dataSource: getIt.get<LocalCategoryManagerDataSource>(),
                name: filteredBudger[index].key,
                values: filteredBudger[index].value,
              ),
            ),
          ),
        );
        return ScreenTypeLayout.builder(
          mobile: (_) => BudgetOverviewMobilePage(
            valueNotifier: valueNotifier,
            child: child,
          ),
          tablet: (_) => BudgetOverviewTabletPage(
            valueNotifier: valueNotifier,
            child: child,
          ),
        );
      },
    );
  }
}
