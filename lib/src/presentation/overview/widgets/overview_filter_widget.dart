import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../summary/controller/summary_controller.dart';
import '../cubit/budget_cubit.dart';
import 'overview_mobile_widget.dart';
import 'overview_tablet_widget.dart';

class OverviewFilter extends StatelessWidget {
  const OverviewFilter({
    super.key,
    required this.budgetCubit,
    required this.summaryController,
  });

  final BudgetCubit budgetCubit;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      tablet: OverviewTablet(
        summaryController: summaryController,
        budgetCubit: budgetCubit,
      ),
      mobile: OverviewMobile(
        summaryController: summaryController,
        budgetCubit: budgetCubit,
      ),
    );
  }
}
