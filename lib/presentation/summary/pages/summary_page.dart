import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/service_locator.dart';
import '../../filter_widget/cubit/filter_cubit.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/context_extensions.dart';
import '../../filter_widget/filter_budget_widget.dart';
import '../../goal/widget/color_palette.dart';
import '../../home/widgets/welcome_widget.dart';
import '../../search/pages/search_page.dart';
import '../../settings/widgets/user_profile_widget.dart';
import '../cubit/summary_cubit.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_total_widget.dart';
import '../widgets/welcome_name_widget.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final SummaryCubit summaryCubit = locator.get();
  final FilterCubit filterCubit = locator.get();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: filterCubit,
      listener: (context, state) {
        if (state is FilterBudgetState) {
          summaryCubit.updateFilter(state.filterBudget);
        }
      },
      child: BlocProvider(
        create: (context) => summaryCubit,
        child: ScreenTypeLayout(
          breakpoints: const ScreenBreakpoints(
            tablet: 673,
            desktop: 1280,
            watch: 300,
          ),
          mobile: Scaffold(
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ColorPalette(),
                      ),
                    );
                  },
                  onTap: () => showModalBottomSheet(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width >= 700
                          ? 700
                          : double.infinity,
                    ),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    context: context,
                    builder: (_) => const UserProfilePage(),
                  ),
                  child: const WelcomeWidget(),
                ),
              ],
              leading: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchPage(),
                  );
                },
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.only(bottom: 124),
              children: [
                const WelcomeNameWidget(),
                const ExpenseTotalWidget(),
                const SizedBox(height: 8),
                FilterBudgetToggleWidget(filterCubit: filterCubit),
                const ExpenseHistory(),
              ],
            ),
          ),
          tablet: Scaffold(
            appBar: context.materialYouAppBar(
              '',
              leadingWidget: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchPage(),
                  );
                },
              ),
              actions: [
                GestureDetector(
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ColorPalette(),
                      ),
                    );
                  },
                  onTap: () => showModalBottomSheet(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width >= 700
                          ? 700
                          : double.infinity,
                    ),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    context: context,
                    builder: (_) => const UserProfilePage(),
                  ),
                  child: const WelcomeWidget(),
                ),
              ],
            ),
            body: SafeArea(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        WelcomeNameWidget(),
                        ExpenseTotalWidget(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FilterBudgetToggleWidget(filterCubit: filterCubit),
                          const ExpenseHistory(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          desktop: Scaffold(
            appBar: context.materialYouAppBar(
              '',
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SearchPage(),
                    );
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: const [
                        ExpenseTotalWidget(),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SingleChildScrollView(child: ExpenseHistory()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
