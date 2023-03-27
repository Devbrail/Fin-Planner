import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../data/expense/model/expense_model.dart';
import '../controller/settings_controller.dart';
import 'summary_desktop_page.dart';
import 'summary_mobile_page.dart';
import 'summary_tablet_page.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilterExpense filterExpense =
        getIt.get<SettingsController>().fetchFilterExpense;
    final ValueNotifier<FilterExpense> valueNotifier =
        ValueNotifier<FilterExpense>(filterExpense);
    return ValueListenableBuilder<Box<ExpenseModel>>(
      valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
      builder: (_, value, child) {
        final expenses = value.values.toEntities();
        return ScreenTypeLayout(
          breakpoints: const ScreenBreakpoints(
            tablet: 673,
            desktop: 799,
            watch: 300,
          ),
          mobile: SummaryMobilePage(
            valueNotifier: valueNotifier,
            expenses: expenses,
          ),
          tablet: SummaryTabletPage(
            valueNotifier: valueNotifier,
            expenses: expenses,
          ),
          desktop: SummaryDesktopPage(
            valueNotifier: valueNotifier,
            expenses: expenses,
          ),
        );
      },
    );
  }
}
