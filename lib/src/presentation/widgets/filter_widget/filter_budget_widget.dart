import 'package:flutter/material.dart';

import '../../../core/enum/filter_budget.dart';
import '../paisa_chip.dart';
import '../paisa_toggle_button.dart';

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
    return ValueListenableBuilder<FilterBudget>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        if (showAsList) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Text(
                    'Filter list',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(
                      left: 24, right: 24, bottom: 16, top: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PaisaToggleButton(
                        itemIndex: ItemIndex.first,
                        title: FilterBudget.daily.name(context),
                        isSelected: FilterBudget.daily == value,
                        onPressed: () =>
                            valueNotifier.value = FilterBudget.daily,
                      ),
                      Divider(
                        indent: 0,
                        thickness: 1,
                        height: 1,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      PaisaToggleButton(
                        title: FilterBudget.weekly.name(context),
                        isSelected: FilterBudget.weekly == value,
                        onPressed: () =>
                            valueNotifier.value = FilterBudget.weekly,
                      ),
                      Divider(
                        indent: 0,
                        thickness: 1,
                        height: 1,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      PaisaToggleButton(
                        title: FilterBudget.monthly.name(context),
                        isSelected: FilterBudget.monthly == value,
                        onPressed: () =>
                            valueNotifier.value = FilterBudget.monthly,
                      ),
                      Divider(
                        indent: 0,
                        thickness: 1,
                        height: 1,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      PaisaToggleButton(
                        title: FilterBudget.yearly.name(context),
                        isSelected: FilterBudget.yearly == value,
                        onPressed: () =>
                            valueNotifier.value = FilterBudget.yearly,
                      ),
                      Divider(
                        indent: 0,
                        thickness: 1,
                        height: 1,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      PaisaToggleButton(
                        itemIndex: ItemIndex.last,
                        title: FilterBudget.all.name(context),
                        isSelected: FilterBudget.all == value,
                        onPressed: () => valueNotifier.value = FilterBudget.all,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
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
              ),
            ),
          );
        }
      },
    );
  }
}
