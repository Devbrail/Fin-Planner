import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../core/common.dart';
import '../../../../core/enum/filter_budget.dart';
import '../../../../domain/expense/entities/expense.dart';
import '../../../summary/controller/summary_controller.dart';
import '../../../widgets/filter_widget/paisa_filter_transaction_widget.dart';
import '../../../widgets/paisa_chip.dart';

class BudgetOverviewPageV2 extends StatefulWidget {
  const BudgetOverviewPageV2({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  State<BudgetOverviewPageV2> createState() => _BudgetOverviewPageV2State();
}

class _BudgetOverviewPageV2State extends State<BudgetOverviewPageV2> {
  final SummaryController summaryController = getIt.get<SummaryController>();
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FilterExpense>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        final result = widget.expenses.groupByTime(value);

        return ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 80,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final item = result[index].key;
                  return PaisaMaterialYouChip(
                    title: item,
                    onPressed: () {
                      setState(() {
                        selectedItem = item;
                      });
                    },
                    isSelected: item == selectedItem,
                  );
                },
              ),
            ),
            CategoryListWidget(
              expenses:
                  widget.expenses.groupByTimeList(value)[selectedItem] ?? [],
              summaryController: summaryController,
              totalExpense: widget.expenses.totalExpense,
            ),
          ],
        );
      },
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    super.key,
    required this.expenses,
    required this.summaryController,
    required this.totalExpense,
  });

  final List<Expense> expenses;
  final double totalExpense;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    final result = groupBy(
            expenses,
            (Expense expense) =>
                summaryController.getCategory(expense.categoryId)!)
        .entries
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: result.length,
      itemBuilder: (context, index) {
        final item = result[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Color(item.key.color ?? Colors.amber.shade100.value)
                            .withOpacity(0.25),
                    child: Icon(
                      IconData(
                        item.key.icon,
                        fontFamily: 'Material Design Icons',
                        fontPackage: 'material_design_icons_flutter',
                      ),
                      color:
                          Color(item.key.color ?? Colors.amber.shade100.value),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.key.name),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                          value: expenses.totalExpense / totalExpense),
                    ),
                  ),
                  Text(item.value.totalExpense.toCurrency())
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
