import 'package:flutter/material.dart';
import 'package:flutter_paisa/common/constants/util.dart';
import 'package:flutter_paisa/data/category/datasources/category_datasource.dart';
import 'package:flutter_paisa/data/category/model/category.dart';
import 'package:flutter_paisa/data/expense/model/expense.dart';
import 'package:flutter_paisa/presentation/budget_overview/widgets/budget_item_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
