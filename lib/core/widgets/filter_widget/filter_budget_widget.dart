import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/home/presentation/controller/summary_controller.dart';

class FilterBudgetToggleWidget extends StatelessWidget {
  const FilterBudgetToggleWidget({
    Key? key,
    this.showAsList = false,
    required this.summaryController,
  }) : super(key: key);

  final bool showAsList;
  final SummaryController summaryController;

  void updateFilter(FilterExpense filterExpense) {
    summaryController.filterExpenseNotifier.value = filterExpense;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FilterExpense>(
      valueListenable: summaryController.filterExpenseNotifier,
      builder: (_, value, child) {
        summaryController.settingsUseCase.put(selectedFilterExpenseKey, value);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                PaisaPillChip(
                  title: FilterExpense.daily.stringValue(context),
                  isSelected: FilterExpense.daily == value,
                  onPressed: () => summaryController
                      .filterExpenseNotifier.value = FilterExpense.daily,
                ),
                PaisaPillChip(
                  title: FilterExpense.weekly.stringValue(context),
                  isSelected: FilterExpense.weekly == value,
                  onPressed: () => summaryController
                      .filterExpenseNotifier.value = FilterExpense.weekly,
                ),
                PaisaPillChip(
                  title: FilterExpense.monthly.stringValue(context),
                  isSelected: FilterExpense.monthly == value,
                  onPressed: () => summaryController
                      .filterExpenseNotifier.value = FilterExpense.monthly,
                ),
                PaisaPillChip(
                  title: FilterExpense.yearly.stringValue(context),
                  isSelected: FilterExpense.yearly == value,
                  onPressed: () => summaryController
                      .filterExpenseNotifier.value = FilterExpense.yearly,
                ),
                PaisaPillChip(
                  title: FilterExpense.all.stringValue(context),
                  isSelected: FilterExpense.all == value,
                  onPressed: () => summaryController
                      .filterExpenseNotifier.value = FilterExpense.all,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
