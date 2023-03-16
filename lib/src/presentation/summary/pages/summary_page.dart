import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/core/common.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/enum/filter_budget.dart';
import '../../../data/expense/model/expense_model.dart';
import 'summary_desktop_page.dart';
import 'summary_mobile_page.dart';
import 'summary_tablet_page.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({
    Key? key,
    required this.valueNotifier,
  }) : super(key: key);

  final ValueNotifier<FilterBudget> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ExpenseModel>>(
      valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
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
    );
  }
}
