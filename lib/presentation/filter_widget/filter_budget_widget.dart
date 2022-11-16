import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/enum/filter_budget.dart';
import '../widgets/paisa_chip.dart';
import 'cubit/filter_cubit.dart';

class FilterBudgetToggleWidget extends StatelessWidget {
  const FilterBudgetToggleWidget({
    Key? key,
    required this.filterCubit,
  }) : super(key: key);

  final FilterCubit filterCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder(
          bloc: filterCubit,
          builder: (context, state) {
            if (state is FilterBudgetState) {
              return Row(
                children: [
                  MaterialYouChip(
                    title: FilterBudget.daily.name(context),
                    isSelected: FilterBudget.daily == state.filterBudget,
                    onPressed: () =>
                        filterCubit.updateFilterBudget(FilterBudget.daily),
                  ),
                  MaterialYouChip(
                    title: FilterBudget.weekly.name(context),
                    isSelected: FilterBudget.weekly == state.filterBudget,
                    onPressed: () =>
                        filterCubit.updateFilterBudget(FilterBudget.weekly),
                  ),
                  MaterialYouChip(
                    title: FilterBudget.monthly.name(context),
                    isSelected: FilterBudget.monthly == state.filterBudget,
                    onPressed: () =>
                        filterCubit.updateFilterBudget(FilterBudget.monthly),
                  ),
                  MaterialYouChip(
                    title: FilterBudget.yearly.name(context),
                    isSelected: FilterBudget.yearly == state.filterBudget,
                    onPressed: () =>
                        filterCubit.updateFilterBudget(FilterBudget.yearly),
                  ),
                  MaterialYouChip(
                    title: FilterBudget.all.name(context),
                    isSelected: FilterBudget.all == state.filterBudget,
                    onPressed: () =>
                        filterCubit.updateFilterBudget(FilterBudget.all),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
