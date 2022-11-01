import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paisa/di/service_locator.dart';
import 'package:flutter_paisa/presentation/summary/cubit/summary_cubit.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/extensions.dart';
import '../../budget_overview/widgets/filter_budget_widget.dart';
import '../../goal/widget/color_palette.dart';
import '../../home/widgets/welcome_widget.dart';
import '../../search/pages/search_page.dart';
import '../../settings/widgets/user_profile_widget.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_total_widget.dart';
import '../widgets/welcome_name_widget.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final SummaryCubit summaryCubit = locator.get();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => summaryCubit,
      child: ScreenTypeLayout(
        mobile: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                actions: [
                  GestureDetector(
                    onLongPress: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ColorPalette()));
                    }),
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
                pinned: true,
                expandedHeight: 366.0 + kToolbarHeight,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: kToolbarHeight),
                        WelcomeNameWidget(),
                        ExpenseTotalWidget(),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 56),
                  child: FilterBudgetWidget(
                    onSelected: (budget) {
                      summaryCubit.updateFilter(budget);
                    },
                  ),
                ),
              ),
            ];
          },
          body: const CustomScrollView(
            slivers: [
              SliverFillRemaining(
                fillOverscroll: false,
                hasScrollBody: true,
                child: ExpenseHistory(),
              )
            ],
          ),
        ),
        tablet: Scaffold(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      WelcomeNameWidget(),
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
    );
  }
}
