import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/features/account/presentation/pages/accounts_page.dart';
import 'package:paisa/features/category/presentation/pages/category_list_page.dart';
import 'package:paisa/features/debit/presentation/pages/debts_page.dart';
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:paisa/features/home/presentation/cubit/overview/overview_cubit.dart';
import 'package:paisa/features/home/presentation/pages/budget/budget_page.dart';
import 'package:paisa/features/home/presentation/pages/overview/overview_page.dart';
import 'package:paisa/features/home/presentation/pages/summary/summary_page.dart';
import 'package:paisa/features/recurring/presentation/page/recurring_page.dart';
import 'package:paisa/features/home/presentation/controller/summary_controller.dart';
import 'package:paisa/main.dart';
import 'package:provider/provider.dart';

import '../cubit/combined_transaction/combined_transaction_cubit.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> pages = {
      0: SummaryPage(cubit: getIt.get<CombinedTransactionCubit>()),
      1: const AccountsPage(),
      2: const DebtsPage(),
      3: OverViewPage(
        summaryController: Provider.of<SummaryController>(context),
        budgetCubit: BlocProvider.of<OverviewCubit>(context),
      ),
      4: const CategoryListPage(),
      5: BudgetPage(
        summaryController: Provider.of<SummaryController>(context),
      ),
      6: const RecurringPage(),
    };
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (HomeState previous, HomeState current) =>
          current is CurrentIndexState,
      builder: (BuildContext context, HomeState state) {
        if (state is CurrentIndexState) {
          return PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation,
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
