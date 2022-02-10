import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/time.dart';
import '../../../common/constants/extensions.dart';
import '../../../common/constants/util.dart';
import '../../../common/enum/box_types.dart';
import '../../../common/enum/filter_budget.dart';
import '../../../common/widgets/empty_widget.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../data/category/datasources/category_datasource.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import '../widgets/budget_item_widget.dart';
import '../widgets/filter_budget_widget.dart';

class BudgetOverViewPage extends StatefulWidget {
  const BudgetOverViewPage({Key? key}) : super(key: key);

  @override
  State<BudgetOverViewPage> createState() => _BudgetOverViewPageState();
}

class _BudgetOverViewPageState extends State<BudgetOverViewPage> {
  final CategoryDataSource categoryDataSource = locator.get();
  FilterBudget selectedType = FilterBudget.daily;
  DateTimeRange? dateTimeRange;

  Future<void> _dateRangePicker() async {
    final intialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(
        const Duration(days: 3),
      ),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateTimeRange ?? intialDateRange,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (newDateRange == null) return;
    dateTimeRange = newDateRange;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: Scaffold(
        appBar: materialYouAppBar(
          context,
          AppLocalizations.of(context)!.budgetOverView,
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: _dateRangePicker,
          heroTag: 'date_range',
          key: const Key('date_range'),
          tooltip: AppLocalizations.of(context)!.addCategory,
          child: const Icon(Icons.date_range),
        ),
        body: ValueListenableBuilder<Box<Expense>>(
          valueListenable:
              Hive.box<Expense>(BoxType.expense.stringValue).listenable(),
          builder: (context, value, _) {
            List<Expense> expenses = value.values.toList();
            if (dateTimeRange != null) {
              expenses = value.isFilterTimeBetween(dateTimeRange!);
            }
            if (expenses.isEmpty) {
              return EmptyWidget(
                icon: Icons.paid,
                title: AppLocalizations.of(context)!.errorNoBudget,
                description:
                    AppLocalizations.of(context)!.errorNoBudgetDescription,
              );
            }
            expenses.sort((a, b) => a.time.compareTo(b.time));

            final filterBudget = groupBy(expenses,
                    (Expense element) => element.time.formated(selectedType))
                .entries
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterBudgetWidget(
                  onSelected: (budget) {
                    selectedType = budget;
                    setState(() {});
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterBudget.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BudgetSection(
                        name: filterBudget[index].key,
                        dataSource: categoryDataSource,
                        values: filterBudget[index].value,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      tablet: Scaffold(
        appBar: materialYouAppBar(
          context,
          AppLocalizations.of(context)!.budget,
          actions: [
            FilterBudgetWidget(
              onSelected: (budget) {
                selectedType = budget;
                setState(() {});
              },
            ),
          ],
        ),
        body: ValueListenableBuilder<Box<Expense>>(
          valueListenable: Hive.box<Expense>('expense').listenable(),
          builder: (context, value, Widget? child) {
            var expenses = value.values.toList();
            if (expenses.isEmpty) {
              return EmptyWidget(
                icon: Icons.paid,
                title: AppLocalizations.of(context)!.errorNoBudget,
                description:
                    AppLocalizations.of(context)!.errorNoBudgetDescription,
              );
            }

            final filterBudget = groupBy(expenses,
                    (Expense element) => element.time.formated(selectedType))
                .entries
                .toList();

            return ListView.builder(
              shrinkWrap: true,
              itemCount: filterBudget.length,
              itemBuilder: (BuildContext context, int index) {
                return BudgetSection(
                  name: filterBudget[index].key,
                  values: filterBudget[index].value,
                  dataSource: categoryDataSource,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class BudgetSection extends StatelessWidget {
  const BudgetSection({
    Key? key,
    required this.values,
    required this.name,
    required this.dataSource,
  }) : super(key: key);

  final String name;
  final List<Expense> values;
  final CategoryDataSource dataSource;

  List<MapEntry<Category, List<Expense>>> _filterCategory(
    List<Expense> expenses,
  ) {
    return groupBy(expenses,
            (Expense element) => dataSource.fetchCategory(element.categoryId))
        .entries
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            bottom: 8,
            right: 16,
            top: 16,
          ),
          child: Text(
            name,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ScreenTypeLayout(
          mobile: BudgetOverViewList(
            maps: _filterCategory(values),
            crossAxisCount: 2,
          ),
          tablet: BudgetOverViewList(
            maps: _filterCategory(values),
            crossAxisCount: 4,
          ),
        )
      ],
    );
  }
}

class BudgetOverViewList extends StatelessWidget {
  const BudgetOverViewList({
    Key? key,
    required this.maps,
    required this.crossAxisCount,
  }) : super(key: key);

  final List<MapEntry<Category, List<Expense>>> maps;
  final int crossAxisCount;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: maps.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return BudgetItem(
          category: maps[index].key,
          expenses: maps[index].value,
        );
      },
    );
  }
}
