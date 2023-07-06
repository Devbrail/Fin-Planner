import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/common.dart';

import '../../widgets/paisa_empty_widget.dart';
import '../cubit/budget_cubit.dart';
import 'category_list_widget.dart';

class OverviewListView extends StatelessWidget {
  const OverviewListView({
    super.key,
    required this.budgetCubit,
  });

  final BudgetCubit budgetCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: budgetCubit,
      buildWhen: (previous, current) =>
          current is FilteredCategoryListState ||
          current is EmptyFilterListState,
      builder: (context, state) {
        if (state is FilteredCategoryListState) {
          if (state.categoryGrouped.isEmpty) {
            return EmptyWidget(
              icon: Icons.paid,
              title: context.loc.emptyOverviewMessageTitle,
              description: context.loc.emptyOverviewMessageSubtitle,
            );
          } else {
            return CategoryListWidget(
              categoryGrouped: state.categoryGrouped,
              totalExpense: state.totalExpense,
            );
          }
        } else {
          return EmptyWidget(
            icon: Icons.paid,
            title: context.loc.emptyOverviewMessageTitle,
            description: context.loc.emptyOverviewMessageSubtitle,
          );
        }
      },
    );
  }
}
