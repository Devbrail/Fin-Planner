import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/presentation/budget_overview/cubit/filter_cubit.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/extensions.dart';
import '../../../common/constants/time.dart';
import '../../../common/constants/util.dart';
import '../../../common/enum/box_types.dart';
import '../../../common/enum/filter_budget.dart';
import '../../../common/widgets/empty_widget.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import '../widgets/budget_section_widget.dart';
import '../widgets/filter_budget_widget.dart';

class BudgetOverViewPage extends StatefulWidget {
  const BudgetOverViewPage({
    Key? key,
    required this.categoryDataSource,
  }) : super(key: key);

  final CategoryLocalDataSource categoryDataSource;
  @override
  State<BudgetOverViewPage> createState() => _BudgetOverViewPageState();
}

class _BudgetOverViewPageState extends State<BudgetOverViewPage> {
  final FilterCubit filterCubit = locator.get();

  DateTimeRange? dateTimeRange;

  Future<void> _dateRangePicker() async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 3)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateTimeRange ?? initialDateRange,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (_, child) {
        return Theme(
          data: ThemeData.from(colorScheme: Theme.of(context).colorScheme)
              .copyWith(
            appBarTheme: Theme.of(context).appBarTheme,
          ),
          child: child!,
        );
      },
    );
    if (newDateRange == null || newDateRange == dateTimeRange) return;
    dateTimeRange = newDateRange;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: Scaffold(
        appBar: context.materialYouAppBar(
          AppLocalizations.of(context)!.budgetOverViewLabel,
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: _dateRangePicker,
          heroTag: 'date_range',
          key: const Key('date_range'),
          tooltip: AppLocalizations.of(context)!.addCategoryLabel,
          child: const Icon(Icons.date_range),
        ),
        body: ValueListenableBuilder<Box<Expense>>(
          valueListenable:
              Hive.box<Expense>(BoxType.expense.stringValue).listenable(),
          builder: (context, value, _) {
            List<Expense> expenses = value.budgetOverView;
            if (dateTimeRange != null) {
              expenses = value.isFilterTimeBetween(dateTimeRange!);
            }
            if (expenses.isEmpty) {
              return EmptyWidget(
                icon: Icons.paid,
                title: AppLocalizations.of(context)!.errorNoBudgetLabel,
                description:
                    AppLocalizations.of(context)!.errorNoBudgetDescriptionLabel,
              );
            }
            expenses.sort((a, b) => a.time.compareTo(b.time));
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterBudgetWidget(
                  onSelected: (budget) => filterCubit.updateFilter(budget),
                ),
                BlocBuilder(
                  bloc: filterCubit,
                  builder: (context, state) {
                    if (state is FilterBudgetState) {
                      final filterBudget = groupBy(
                              expenses,
                              (Expense element) =>
                                  element.time.formatted(state.filterBudget))
                          .entries
                          .toList();
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 128),
                          itemCount: filterBudget.length,
                          itemBuilder: (BuildContext context, int index) {
                            return BudgetSection(
                              name: filterBudget[index].key,
                              dataSource: widget.categoryDataSource,
                              values: filterBudget[index].value,
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
      tablet: Scaffold(
        appBar: context.materialYouAppBar(
          AppLocalizations.of(context)!.budgetOverViewLabel,
          actions: [
            FilterBudgetWidget(
              onSelected: (budget) => filterCubit.updateFilter(budget),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: _dateRangePicker,
          heroTag: 'date_range',
          key: const Key('date_range'),
          tooltip: AppLocalizations.of(context)!.addCategoryLabel,
          child: const Icon(Icons.date_range),
        ),
        body: ValueListenableBuilder<Box<Expense>>(
          valueListenable: locator.get<Box<Expense>>().listenable(),
          builder: (context, value, _) {
            List<Expense> expenses = value.budgetOverView;
            if (dateTimeRange != null) {
              expenses = value.isFilterTimeBetween(dateTimeRange!);
            }
            if (expenses.isEmpty) {
              return EmptyWidget(
                icon: Icons.paid,
                title: AppLocalizations.of(context)!.errorNoBudgetLabel,
                description:
                    AppLocalizations.of(context)!.errorNoBudgetDescriptionLabel,
              );
            }
            expenses.sort((a, b) => a.time.compareTo(b.time));
            return BlocBuilder(
              bloc: filterCubit,
              builder: (context, state) {
                if (state is FilterBudgetState) {
                  final filterBudget = groupBy(
                          expenses,
                          (Expense element) =>
                              element.time.formatted(state.filterBudget))
                      .entries
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterBudget.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BudgetSection(
                        name: filterBudget[index].key,
                        values: filterBudget[index].value,
                        dataSource: widget.categoryDataSource,
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
