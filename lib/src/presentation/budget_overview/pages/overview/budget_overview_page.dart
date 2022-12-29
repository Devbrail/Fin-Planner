import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/common.dart';
import '../../../../data/category/data_sources/category_local_data_source.dart';
import '../../../../data/expense/model/expense.dart';
import '../../../../service_locator.dart';
import '../../../widgets/filter_widget/paisa_filter_transaction_widget.dart';
import '../../../widgets/future_resolve.dart';
import '../../../widgets/paisa_empty_widget.dart';
import '../../widgets/budget_section_widget.dart';
import '../../widgets/filter_budget_widget.dart';
import '../../widgets/filter_date_range_widget.dart';
import 'budget_overview_mobile_page.dart';
import 'budget_overview_tablet_page.dart';

class BudgetOverViewPage extends StatefulWidget {
  const BudgetOverViewPage({
    Key? key,
    required this.categoryDataSource,
    required this.dateTimeRangeNotifier,
  }) : super(key: key);

  final Future<LocalCategoryManagerDataSource> categoryDataSource;

  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier;
  @override
  State<BudgetOverViewPage> createState() => _BudgetOverViewPageState();
}

class _BudgetOverViewPageState extends State<BudgetOverViewPage> {
  @override
  Widget build(BuildContext context) {
    return FutureResolve<LocalCategoryManagerDataSource>(
      future: widget.categoryDataSource,
      builder: (dataSource) {
        return ValueListenableBuilder<Box<Expense>>(
          valueListenable: locator.get<Box<Expense>>().listenable(),
          builder: (context, value, _) {
            List<Expense> expenses = value.budgetOverView;
            if (expenses.isEmpty) {
              return EmptyWidget(
                icon: Icons.paid,
                title: AppLocalizations.of(context)!.errorNoBudgetLabel,
                description:
                    AppLocalizations.of(context)!.errorNoBudgetDescriptionLabel,
              );
            }
            final child = FilterDateRangeWidget(
              dateTimeRangeNotifier: widget.dateTimeRangeNotifier,
              expenses: expenses,
              builder: (List<Expense> expenses) {
                return FilterBudgetWidget(
                  valueNotifier: valueNotifier,
                  expenses: expenses,
                  builder: (filteredBudger) {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 128),
                      itemCount: filteredBudger.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BudgetSection(
                          dataSource: dataSource,
                          name: filteredBudger[index].key,
                          values: filteredBudger[index].value,
                        );
                      },
                    );
                  },
                );
              },
            );
            return ScreenTypeLayout(
              mobile: BudgetOverviewMobilePage(
                valueNotifier: valueNotifier,
                child: child,
              ),
              tablet: BudgetOverviewTabletPage(
                valueNotifier: valueNotifier,
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
