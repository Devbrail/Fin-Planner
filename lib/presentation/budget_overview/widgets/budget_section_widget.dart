import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/common.dart';
import '../../../common/constants/list_util.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';
import 'budget_item_widget.dart';

class BudgetSection extends StatelessWidget {
  const BudgetSection({
    Key? key,
    required this.values,
    required this.name,
    required this.dataSource,
  }) : super(key: key);

  final String name;
  final List<Expense> values;
  final CategoryLocalDataSource dataSource;

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
          breakpoints: const ScreenBreakpoints(
            tablet: 600,
            desktop: 700,
            watch: 300,
          ),
          mobile: BudgetOverViewList(
            maps: _filterCategory(values),
            crossAxisCount: 2,
          ),
          tablet: BudgetOverViewList(
            maps: _filterCategory(values),
            crossAxisCount: 3,
          ),
          desktop: BudgetOverViewList(
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

class ProgressBar extends StatelessWidget {
  final double max;
  final double current;
  final Color color;

  const ProgressBar({
    Key? key,
    required this.max,
    required this.current,
    this.color = Colors.black,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current / max) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: 6,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
