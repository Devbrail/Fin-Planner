import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../overview/cubit/budget_cubit.dart';
import '../../recurring/page/recurring_page.dart';
import 'package:provider/provider.dart';

import '../../accounts/pages/accounts_page.dart';
import '../../budget/pages/budget_page.dart';
import '../../category/pages/category_list_page.dart';
import '../../debits/pages/debts_page.dart';
import '../../overview/pages/overview_page.dart';
import '../../summary/controller/summary_controller.dart';
import '../../summary/pages/summary_page.dart';
import '../bloc/home_bloc.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> pages = {
      0: const SummaryPage(),
      1: const AccountsPage(),
      2: const DebtsPage(),
      3: OverViewPage(
        summaryController: Provider.of<SummaryController>(context),
        budgetCubit: BlocProvider.of<BudgetCubit>(context),
      ),
      4: const CategoryListPage(),
      5: BudgetPage(
        summaryController: Provider.of<SummaryController>(context),
      ),
      6: const RecurringPage(),
    };
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
