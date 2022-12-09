import 'package:flutter/material.dart';

import '../../core/enum/filter_budget.dart';
import '../widgets/paisa_chip.dart';

class FilterBudgetToggleWidget extends StatelessWidget {
  const FilterBudgetToggleWidget({
    Key? key,
    required this.valueNotifier,
  }) : super(key: key);

  final ValueNotifier<FilterBudget> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ValueListenableBuilder<FilterBudget>(
            valueListenable: valueNotifier,
            builder: (context, value, child) {
              return Row(
                children: [
                  MaterialYouChip(
                    title: FilterBudget.daily.name(context),
                    isSelected: FilterBudget.daily == value,
                    onPressed: () => valueNotifier.value = FilterBudget.daily,
                  ),
                  MaterialYouChip(
                    title: FilterBudget.weekly.name(context),
                    isSelected: FilterBudget.weekly == value,
                    onPressed: () => valueNotifier.value = FilterBudget.weekly,
                  ),
                  MaterialYouChip(
                    title: FilterBudget.monthly.name(context),
                    isSelected: FilterBudget.monthly == value,
                    onPressed: () => valueNotifier.value = FilterBudget.monthly,
                  ),
                  MaterialYouChip(
                    title: FilterBudget.yearly.name(context),
                    isSelected: FilterBudget.yearly == value,
                    onPressed: () => valueNotifier.value = FilterBudget.yearly,
                  ),
                  MaterialYouChip(
                    title: FilterBudget.all.name(context),
                    isSelected: FilterBudget.all == value,
                    onPressed: () => valueNotifier.value = FilterBudget.all,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
