import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    super.key,
    required this.categoryGrouped,
    required this.totalExpense,
  });

  final List<MapEntry<Category, List<Expense>>> categoryGrouped;
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 124),
      itemCount: categoryGrouped.length,
      itemBuilder: (context, index) {
        final MapEntry<Category, List<Expense>> map = categoryGrouped[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      IconData(
                        map.key.icon,
                        fontFamily: 'Material Design Icons',
                        fontPackage: 'material_design_icons_flutter',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(map.key.name),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: map.value.totalExpense / totalExpense,
                          color: Color(
                              map.key.color ?? Colors.amber.shade100.value),
                        ),
                      ),
                    ),
                  ),
                  Text(map.value.totalExpense.toCurrency())
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
