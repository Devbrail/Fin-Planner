import 'package:flutter/material.dart';

import '../../../common/enum/filter_budget.dart';
import '../../../common/widgets/material_you_chip.dart';

class FilterBudgetWidget extends StatefulWidget {
  const FilterBudgetWidget({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final Function(FilterBudget) onSelected;

  @override
  State<FilterBudgetWidget> createState() => _FilterBudgetWidgetState();
}

class _FilterBudgetWidgetState extends State<FilterBudgetWidget> {
  FilterBudget selectedType = FilterBudget.daily;

  void _update(FilterBudget type) {
    selectedType = type;
    setState(() {});
    widget.onSelected(type);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: FilterBudget.values.map((type) {
            final isSelected = selectedType == type;
            return MaterialYouChip(
              title: type.name(context),
              isSelected: isSelected,
              onPressed: () => _update(type),
            );
          }).toList(),
        ),
      ),
    );
  }
}
