import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/presentation/summary/controller/settings_controller.dart';
import '../../../core/enum/box_types.dart';
import '../controller/summary_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../data/expense/model/expense_model.dart';
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
        Provider.of<SettingsController>(context, listen: false)
            .fetchFilterExpense;
    final ValueNotifier<FilterExpense> valueNotifier =
        ValueNotifier<FilterExpense>(filterExpense);
    return Provider<SummaryController>(
      create: (context) => getIt.get<SummaryController>(),
      child: ValueListenableBuilder<Box<ExpenseModel>>(
        valueListenable: getIt.get<Box<ExpenseModel>>().listenable(keys: [
          BoxType.accounts.name,
          BoxType.category.name,
          BoxType.expense.name,
        ]),
        builder: (_, value, child) {
          final expenses = value.values.toEntities();
          return ScreenTypeLayout.builder(
            breakpoints: const ScreenBreakpoints(
              tablet: 673,
              desktop: 799,
              watch: 300,
            ),
            mobile: (_) => SummaryMobilePage(
              valueNotifier: valueNotifier,
              expenses: expenses,
            ),
            tablet: (_) => SummaryTabletPage(
              valueNotifier: valueNotifier,
              expenses: expenses,
            ),
            desktop: (_) => SummaryDesktopPage(
              valueNotifier: valueNotifier,
              expenses: expenses,
            ),
          );
        },
      ),
    );
  }
}
