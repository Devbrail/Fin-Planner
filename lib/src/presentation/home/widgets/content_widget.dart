import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/src/presentation/recurring/page/recurring_page.dart';

import '../../accounts/pages/accounts_page.dart';
import '../../budget/pages/budget_page.dart';
import '../../category/pages/category_list_page.dart';
import '../../debits/pages/debts_page.dart';
import '../../overview/pages/overview_page.dart';
import '../../summary/pages/summary_page.dart';
import '../bloc/home_bloc.dart';

class ContentWidget extends StatelessWidget {
  ContentWidget({
    Key? key,
  }) : super(key: key);

  late final Map<int, Widget> pages = {
    0: const SummaryPage(),
    1: const AccountsPage(),
    2: const DebtsPage(),
    3: const OverViewPage(),
    4: const CategoryListPage(),
    5: const BudgetPage(),
    6: const RecurringPage(),
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
