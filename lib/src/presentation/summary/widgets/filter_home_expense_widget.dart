import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../core/enum/filter_budget.dart';
import '../../settings/bloc/settings_controller.dart';
import '../../summary/controller/summary_controller.dart';
import '../../widgets/paisa_toggle_button.dart';

class FilterHomeWidget extends StatelessWidget {
  FilterHomeWidget({super.key});

  final SummaryController summaryController = getIt.get();
  void updateFilter(FilterExpense filterExpense) {
    summaryController.filterHomeExpenseNotifier.value = filterExpense;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FilterExpense>(
      valueListenable: summaryController.filterHomeExpenseNotifier,
      builder: (_, value, child) {
        getIt.get<SettingsController>().setFilterExpense(value, isHome: true);
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
                        updateFilter(FilterExpense.daily);
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
                      onPressed: () {
                        updateFilter(FilterExpense.weekly);
                      },
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
                      onPressed: () => updateFilter(FilterExpense.monthly),
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
                      onPressed: () => updateFilter(FilterExpense.yearly),
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
                      onPressed: () => updateFilter(FilterExpense.all),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
