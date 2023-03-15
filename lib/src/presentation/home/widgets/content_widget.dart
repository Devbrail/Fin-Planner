import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../accounts/pages/accounts_page.dart';
import '../../budget_overview/pages/overview/budget_overview_page.dart';
import '../../category/pages/category_list_page.dart';
import '../../debits/pages/debts_page.dart';
import '../../summary/pages/summary_page.dart';
import '../bloc/home_bloc.dart';

class ContentWidget extends StatelessWidget {
  ContentWidget({
    Key? key,
    required this.dateTimeRangeNotifier,
  }) : super(key: key);

  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier;

  late final Map<PageType, Widget> pages = {
    PageType.home: SummaryPage(
      valueNotifier: ValueNotifier<FilterBudget>(FilterBudget.daily),
    ),
    PageType.accounts: AccountsPage(),
    PageType.category: const CategoryListPage(),
    PageType.budgetOverview: BudgetOverViewPage(
      dateTimeRangeNotifier: dateTimeRangeNotifier,
    ),
    PageType.debts: const DebtsPage(),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<HomeBloc>(context),
      builder: (context, state) {
        if (state is CurrentIndexState) {
          return PageTransitionSwitcher(
            transitionBuilder: (
              child,
              primaryAnimation,
              secondaryAnimation,
            ) =>
                FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            ),
            duration: const Duration(milliseconds: 300),
            child: pages[state.currentPage],
          );
        } else {
          return SizedBox.fromSize();
        }
      },
    );
  }
}
