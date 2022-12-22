import 'package:flutter/material.dart';
import 'package:flutter_paisa/src/presentation/widgets/paisa_toggle_button.dart';

import '../../../core/enum/filter_budget.dart';
import '../paisa_chip.dart';

class FilterBudgetToggleWidget extends StatelessWidget {
  const FilterBudgetToggleWidget({
    Key? key,
    required this.valueNotifier,
    this.showAsList = false,
  }) : super(key: key);

  final ValueNotifier<FilterBudget> valueNotifier;
  final bool showAsList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ValueListenableBuilder<FilterBudget>(
            valueListenable: valueNotifier,
            builder: (context, value, child) {
              if (showAsList) {
                return Column(
                  children: [PaisaToggleButton()],
                );
              }
              return Row(
                children: [
                  PaisaMaterialYouChip(
                    title: FilterBudget.daily.name(context),
                    isSelected: FilterBudget.daily == value,
                    onPressed: () => valueNotifier.value = FilterBudget.daily,
                  ),
                  PaisaMaterialYouChip(
                    title: FilterBudget.weekly.name(context),
                    isSelected: FilterBudget.weekly == value,
                    onPressed: () => valueNotifier.value = FilterBudget.weekly,
                  ),
                  PaisaMaterialYouChip(
                    title: FilterBudget.monthly.name(context),
                    isSelected: FilterBudget.monthly == value,
                    onPressed: () => valueNotifier.value = FilterBudget.monthly,
                  ),
                  PaisaMaterialYouChip(
                    title: FilterBudget.yearly.name(context),
                    isSelected: FilterBudget.yearly == value,
                    onPressed: () => valueNotifier.value = FilterBudget.yearly,
                  ),
                  PaisaMaterialYouChip(
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
