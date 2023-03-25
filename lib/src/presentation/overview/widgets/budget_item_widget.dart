import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
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
    return ScreenTypeLayout.builder(
      breakpoints: const ScreenBreakpoints(
        tablet: 600,
        desktop: 700,
        watch: 300,
      ),
      mobile: (_) => BudgetItemMobileWidget(
        category: category,
        expenses: expenses,
      ),
      tablet: (_) => BudgetItemTableWidget(
        category: category,
        expenses: expenses,
      ),
      desktop: (_) => BudgetItemTableWidget(
        category: category,
        expenses: expenses,
      ),
    );
  }
}
