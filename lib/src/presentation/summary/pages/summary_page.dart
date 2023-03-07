import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/enum/filter_budget.dart';
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
    return ScreenTypeLayout(
      breakpoints: const ScreenBreakpoints(
        tablet: 673,
        desktop: 799,
        watch: 300,
      ),
      mobile: SummaryMobilePage(
        valueNotifier: valueNotifier,
      ),
      tablet: SummaryTabletPage(
        valueNotifier: valueNotifier,
      ),
      desktop: SummaryDesktopPage(
        valueNotifier: valueNotifier,
      ),
    );
  }
}
