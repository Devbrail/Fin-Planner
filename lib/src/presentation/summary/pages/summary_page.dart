import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
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
    return ValueListenableBuilder<Box<ExpenseModel>>(
      valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
      builder: (_, value, child) {
        final expenses = value.values.toEntities();
        return ScreenTypeLayout(
          mobile: SummaryMobilePage(expenses: expenses),
          tablet: SummaryTabletPage(expenses: expenses),
          desktop: SummaryDesktopPage(expenses: expenses),
        );
      },
    );
  }
}
