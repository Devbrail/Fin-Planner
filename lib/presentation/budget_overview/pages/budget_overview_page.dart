import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/time.dart';
import '../../../common/constants/util.dart';
import '../../../common/enum/filter_budget.dart';
import '../../../common/enum/transaction.dart';
import '../../../common/widgets/empty_widget.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';
import '../widgets/budget_graph.dart';
import '../widgets/budget_item_widget.dart';
import '../widgets/filter_budget_widget.dart';

class BudgetOverViewPage extends StatefulWidget {
  const BudgetOverViewPage({Key? key}) : super(key: key);

  @override
  State<BudgetOverViewPage> createState() => _BudgetOverViewPageState();
}

class _BudgetOverViewPageState extends State<BudgetOverViewPage> {
  FilterBudget selectedType = FilterBudget.daily;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: Scaffold(
        appBar: materialYouAppBar(
          context,
          AppLocalizations.of(context)!.budgetOverView,
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
                      return BudgetSection(map: filterBudget[index]);
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

            final graphData = filterBudget
                .map((e) => OrdinalSales(e.key, calcauleTotal(e.value)))
                .toList();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  child: TransactionGraph(
                    seriesList: TransactionGraph.createSampleData(graphData),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: filterBudget.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BudgetSection(map: filterBudget[index]);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  num calcauleTotal(List<Expense> expenses) {
    final total = expenses.fold<double>(0, (previousValue, element) {
      if (element.type == TransactonType.expense) {
        return previousValue + element.currency;
      } else {
        return previousValue + 0;
      }
    });
    return total;
  }
}

class BudgetSection extends StatelessWidget {
  const BudgetSection({
    Key? key,
    required this.map,
  }) : super(key: key);

  final MapEntry<String, List<Expense>> map;

  @override
  Widget build(BuildContext context) {
    final maps = groupBy(map.value, (Expense element) => element.category)
        .entries
        .toList();
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
            map.key,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ScreenTypeLayout(
          mobile: BudgetOverViewList(
            maps: maps,
            crossAxisCount: 2,
          ),
          tablet: BudgetOverViewList(
            maps: maps,
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
