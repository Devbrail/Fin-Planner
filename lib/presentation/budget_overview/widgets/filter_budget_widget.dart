import 'package:flutter/material.dart';
import '../../../common/enum/filter_budget.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    return ScreenTypeLayout(
      mobile: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: FilterBudget.values.map((type) {
              bool isSelected = selectedType == type;
              final borderRadius = isSelected
                  ? BorderRadius.circular(28)
                  : BorderRadius.circular(12);
              final colorPrimary = isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary;
              final colorOnPrimary = isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSecondary;
              return Row(
                children: [
                  GestureDetector(
                    onTap: () => _update(type),
                    child: AnimatedContainer(
                      duration: const Duration(microseconds: 300),
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: colorPrimary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Text(
                          type.name(context),
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: colorOnPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8)
                ],
              );
            }).toList(),
          ),
        ),
      ),
      tablet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: FilterBudget.values.map((type) {
            bool isSelected = selectedType == type;
            final borderRadius = isSelected
                ? BorderRadius.circular(28)
                : BorderRadius.circular(12);
            final colorPrimary = isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary;
            final colorOnPrimary = isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSecondary;

            return Row(
              children: [
                GestureDetector(
                  onTap: () => _update(type),
                  child: AnimatedContainer(
                    duration: const Duration(microseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: colorPrimary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Text(
                        type.name(context),
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: colorOnPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8)
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
