import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/src/presentation/budget_overview/widgets/filter_budget_widget.dart';
import 'package:flutter_paisa/src/presentation/budget_overview/widgets/filter_date_range_widget.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../service_locator.dart';
import '../../filter_widget/filter_budget_widget.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../widgets/budget_section_widget.dart';

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
  final ValueNotifier<FilterBudget> valueNotifier =
      ValueNotifier<FilterBudget>(FilterBudget.daily);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocalCategoryManagerDataSource>(
      future: widget.categoryDataSource,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ValueListenableBuilder<Box<Expense>>(
            valueListenable: locator.get<Box<Expense>>().listenable(),
            builder: (context, value, _) {
              List<Expense> expenses = value.budgetOverView;
              if (expenses.isEmpty) {
                return EmptyWidget(
                  icon: Icons.paid,
                  title: AppLocalizations.of(context)!.errorNoBudgetLabel,
                  description: AppLocalizations.of(context)!
                      .errorNoBudgetDescriptionLabel,
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
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 128),
                          itemCount: filteredBudger.length,
                          itemBuilder: (BuildContext context, int index) {
                            return BudgetSection(
                              dataSource: snapshot.data!,
                              name: filteredBudger[index].key,
                              values: filteredBudger[index].value,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              );
              return ScreenTypeLayout(
                mobile: Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterBudgetToggleWidget(valueNotifier: valueNotifier),
                      child,
                    ],
                  ),
                ),
                tablet: Scaffold(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 24),
                      FilterBudgetToggleWidget(
                        valueNotifier: valueNotifier,
                      ),
                      child
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
