import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../core/enum/filter_budget.dart';
import '../../summary/controller/settings_controller.dart';
import '../paisa_chip.dart';
import '../paisa_toggle_button.dart';

class FilterBudgetToggleWidget extends StatelessWidget {
  const FilterBudgetToggleWidget({
    Key? key,
    required this.valueNotifier,
    this.showAsList = false,
  }) : super(key: key);

  final ValueNotifier<FilterExpense> valueNotifier;
  final bool showAsList;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FilterExpense>(
      valueListenable: valueNotifier,
      builder: (_, value, child) {
        getIt.get<SettingsController>().setFilterExpense(value);
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
                        title: FilterExpense.daily.name(context),
                        isSelected: FilterExpense.daily == value,
                        onPressed: () {
                          valueNotifier.value = FilterExpense.daily;
                        },
                      ),
                      Divider(
                        indent: 0,
                        thickness: 1,
                        height: 1,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      PaisaToggleButton(
                        title: FilterExpense.weekly.name(context),
                        isSelected: FilterExpense.weekly == value,
                        onPressed: () =>
                            valueNotifier.value = FilterExpense.weekly,
                      ),
                      Divider(
                        indent: 0,
                        thickness: 1,
                        height: 1,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      PaisaToggleButton(
                        title: FilterExpense.monthly.name(context),
                        isSelected: FilterExpense.monthly == value,
                        onPressed: () =>
                            valueNotifier.value = FilterExpense.monthly,
                      ),
                      Divider(
                        indent: 0,
                        thickness: 1,
                        height: 1,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      PaisaToggleButton(
                        title: FilterExpense.yearly.name(context),
                        isSelected: FilterExpense.yearly == value,
                        onPressed: () =>
                            valueNotifier.value = FilterExpense.yearly,
                      ),
                      Divider(
                        indent: 0,
                        thickness: 1,
                        height: 1,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      PaisaToggleButton(
                        itemIndex: ItemIndex.last,
                        title: FilterExpense.all.name(context),
                        isSelected: FilterExpense.all == value,
                        onPressed: () =>
                            valueNotifier.value = FilterExpense.all,
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
                    title: FilterExpense.daily.name(context),
                    isSelected: FilterExpense.daily == value,
                    onPressed: () => valueNotifier.value = FilterExpense.daily,
                  ),
                  PaisaMaterialYouChip(
                    title: FilterExpense.weekly.name(context),
                    isSelected: FilterExpense.weekly == value,
                    onPressed: () => valueNotifier.value = FilterExpense.weekly,
                  ),
                  PaisaMaterialYouChip(
                    title: FilterExpense.monthly.name(context),
                    isSelected: FilterExpense.monthly == value,
                    onPressed: () =>
                        valueNotifier.value = FilterExpense.monthly,
                  ),
                  PaisaMaterialYouChip(
                    title: FilterExpense.yearly.name(context),
                    isSelected: FilterExpense.yearly == value,
                    onPressed: () => valueNotifier.value = FilterExpense.yearly,
                  ),
                  PaisaMaterialYouChip(
                    title: FilterExpense.all.name(context),
                    isSelected: FilterExpense.all == value,
                    onPressed: () => valueNotifier.value = FilterExpense.all,
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
