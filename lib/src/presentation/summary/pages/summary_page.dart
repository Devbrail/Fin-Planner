import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/presentation/summary/cubit/summary_cubit.dart';
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
    final SummaryCubit cubit = getIt.get();
    cubit.fetchExpenses();
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return ScreenTypeLayout(
          mobile: SummaryMobilePage(expenses: expenses),
          tablet: SummaryTabletPage(expenses: expenses),
          desktop: SummaryDesktopPage(expenses: expenses),
        );
      },
    );
  }
}
