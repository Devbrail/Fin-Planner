import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';
import 'budget_item_mobile_widget.dart';
import 'budget_tablet_item_widget.dart';

class BudgetItem extends StatelessWidget {
  const BudgetItem({
    Key? key,
    required this.category,
    required this.expenses,
  }) : super(key: key);

  final Category category;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: BudgetItemMobileWidget(
        category: category,
        expenses: expenses,
      ),
      tablet: BudgetItemTableWidget(
        category: category,
        expenses: expenses,
      ),
    );
  }
}
