import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/currency.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';

class BudgetItemTableWidget extends StatelessWidget {
  const BudgetItemTableWidget({
    Key? key,
    required this.category,
    required this.expenses,
  }) : super(key: key);
  final Category category;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return MaterialYouCard(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 24,
                right: 16,
                bottom: 12,
              ),
              child: Icon(
                IconData(category.icon, fontFamily: 'MaterialIcons'),
                color: Theme.of(context).colorScheme.secondary,
                size: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Sparkline(
                  data: expenses.map((e) => e.currency).toList(),
                  useCubicSmoothing: true,
                  cubicSmoothingFactor: 0.2,
                  lineWidth: 4,
                  lineColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                totalExpens(expenses),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
