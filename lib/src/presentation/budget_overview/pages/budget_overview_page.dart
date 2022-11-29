import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/common.dart';
import '../../../common/enum/filter_budget.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import '../../filter_widget/cubit/filter_cubit.dart';
import '../../filter_widget/filter_budget_widget.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../cubit/filter_date_cubit.dart';
import '../widgets/budget_section_widget.dart';

class BudgetOverViewPage extends StatefulWidget {
  const BudgetOverViewPage({
    Key? key,
    required this.categoryDataSource,
    required this.filterDateCubit,
  }) : super(key: key);

  final CategoryLocalDataSource categoryDataSource;
  final FilterDateCubit filterDateCubit;
  @override
  State<BudgetOverViewPage> createState() => _BudgetOverViewPageState();
}

class _BudgetOverViewPageState extends State<BudgetOverViewPage> {
  final FilterCubit filterCubit = locator.get();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: locator.get<Box<Expense>>().listenable(),
      builder: (context, value, _) {
        List<Expense> expenses = value.budgetOverView;
        if (expenses.isEmpty) {
          return EmptyWidget(
            icon: Icons.paid,
            title: AppLocalizations.of(context)!.errorNoBudgetLabel,
            description:
                AppLocalizations.of(context)!.errorNoBudgetDescriptionLabel,
          );
        }
        final child = FilterDateRangeWidget(
          filterDateCubit: widget.filterDateCubit,
          expenses: expenses,
          builder: (List<Expense> expenses) {
            return FilterBudgetWidget(
              filterCubit: filterCubit,
              expenses: expenses,
              builder: (filteredBudger) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 128),
                    itemCount: filteredBudger.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BudgetSection(
                        dataSource: widget.categoryDataSource,
                        name: filteredBudger[index].key,
                        values: filteredBudger[index].value,
                      );
                    },
                  ),
                );
              },
            );
          },
        );
        return ScreenTypeLayout(
          mobile: Scaffold(
            appBar: context.materialYouAppBar(
              AppLocalizations.of(context)!.budgetOverViewLabel,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterBudgetToggleWidget(filterCubit: filterCubit),
                child,
              ],
            ),
          ),
          tablet: Scaffold(
            appBar: context.materialYouAppBar(
              AppLocalizations.of(context)!.budgetOverViewLabel,
              actions: [
                FilterBudgetToggleWidget(filterCubit: filterCubit),
              ],
            ),
            body: Column(
              children: [child],
            ),
          ),
        );
      },
    );
  }
}

class FilterDateRangeWidget extends StatelessWidget {
  const FilterDateRangeWidget({
    super.key,
    required this.builder,
    required this.expenses,
    required this.filterDateCubit,
  });
  final Iterable<Expense> expenses;
  final Widget Function(List<Expense> expenses) builder;
  final FilterDateCubit filterDateCubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: filterDateCubit,
      buildWhen: (previous, current) => current is FilterDateRangeState,
      builder: (context, state) {
        if (state is FilterDateRangeState) {
          return builder
              .call(expenses.isFilterTimeBetween(state.dateTimeRange));
        } else {
          return builder.call(expenses.toList());
        }
      },
    );
  }
}

class FilterBudgetWidget extends StatelessWidget {
  const FilterBudgetWidget({
    super.key,
    required this.filterCubit,
    required this.builder,
    required this.expenses,
  });
  final Iterable<Expense> expenses;
  final FilterCubit filterCubit;
  final Widget Function(
    List<MapEntry<String, List<Expense>>> filteredBudger,
  ) builder;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: filterCubit,
      builder: (context, state) {
        FilterBudget filter = FilterBudget.daily;

        if (state is FilterBudgetState) {
          filter = state.filterBudget;
        }
        return builder.call(expenses.groupByTime(filter));
      },
    );
  }
}
