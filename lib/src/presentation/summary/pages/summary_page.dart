import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../data/expense/model/expense.dart';
import 'summary_desktop_page.dart';
import 'summary_mobile_page.dart';
import 'summary_tablet_page.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final ValueNotifier<FilterBudget> valueNotifier =
      ValueNotifier<FilterBudget>(FilterBudget.daily);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: getIt.get<Box<Expense>>().listenable(),
      builder: (_, value, child) {
        final expenses = value.values.toList();
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
    );
  }
}
