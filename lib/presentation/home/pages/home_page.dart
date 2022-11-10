import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/presentation/budget_overview/cubit/filter_date_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../common/common.dart';
import '../../../di/service_locator.dart';
import '../../accounts/pages/accounts_page.dart';
import '../../budget_overview/pages/budget_overview_page.dart';
import '../../category/pages/category_list_page.dart';
import '../../debits/pages/debts_page.dart';
import '../../goal/widget/color_palette.dart';
import '../../settings/widgets/user_profile_widget.dart';
import '../../summary/pages/summary_page.dart';
import '../../summary/widgets/welcome_name_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/welcome_widget.dart';

late final Function(DateTimeRange dateTimeRange) dateTimeRange;

class LandingPage extends StatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  final HomeBloc homeBloc = locator.get<HomeBloc>();
  final FilterDateCubit filterDateCubit = locator.get<FilterDateCubit>();
  DateTimeRange? dateTimeRange;

  late final Map<PaisaPage, Widget> _pages = {
    PaisaPage.home: const SummaryPage(),
    PaisaPage.accounts: AccountsPage(
      accountsBloc: locator.get(),
    ),
    PaisaPage.category: CategoryListPage(
      addCategoryBloc: locator.get(),
    ),
    PaisaPage.budgetOverview: BudgetOverViewPage(
      categoryDataSource: locator.get(),
      filterDateCubit: filterDateCubit,
    ),
    PaisaPage.debts: const DebtsPage(),
  };

  void _handleClick(PaisaPage page) {
    switch (page) {
      case PaisaPage.accounts:
        context.goNamed(addAccountPath);
        break;
      case PaisaPage.home:
        context.goNamed(addExpensePath);
        break;
      case PaisaPage.category:
        context.goNamed(addCategoryPath);
        break;
      case PaisaPage.debts:
        context.goNamed(addDebitName);
        break;
      case PaisaPage.budgetOverview:
        _dateRangePicker();
        break;
    }
  }

  Widget _floatingActionButtonBig() {
    return BlocBuilder(
      bloc: homeBloc,
      builder: (context, state) {
        if (state is CurrentIndexState) {
          return FloatingActionButton.large(
            onPressed: () => _handleClick(state.currentPage),
            tooltip: AppLocalizations.of(context)!.addExpenseLabel,
            child: state.currentPage != PaisaPage.budgetOverview
                ? const Icon(Icons.add)
                : const Icon(Icons.date_range),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Future<void> _dateRangePicker() async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 3)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateTimeRange ?? initialDateRange,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (_, child) {
        return Theme(
          data: ThemeData.from(colorScheme: Theme.of(context).colorScheme)
              .copyWith(
            appBarTheme: Theme.of(context).appBarTheme,
          ),
          child: child!,
        );
      },
    );
    if (newDateRange == null || newDateRange == dateTimeRange) return;
    dateTimeRange = newDateRange;
    filterDateCubit.filterDate(newDateRange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: WillPopScope(
        onWillPop: () async {
          if (homeBloc.currentPage == PaisaPage.home) {
            return true;
          }
          homeBloc.add(const CurrentIndexEvent(PaisaPage.home));
          return false;
        },
        child: ScreenTypeLayout(
          breakpoints: const ScreenBreakpoints(
            tablet: 600,
            desktop: 700,
            watch: 300,
          ),
          mobile: Scaffold(
            body: ContentWidget(pages: _pages),
            floatingActionButton: _floatingActionButtonBig(),
            bottomNavigationBar: Material(
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: BlocBuilder(
                bloc: homeBloc,
                builder: (context, state) {
                  return NavigationBar(
                    selectedIndex:
                        homeBloc.getIndexFromPage(homeBloc.currentPage),
                    onDestinationSelected: (index) => homeBloc.add(
                        CurrentIndexEvent(homeBloc.getPageFromIndex(index))),
                    destinations: [
                      NavigationDestination(
                        label: AppLocalizations.of(context)!.homeLabel,
                        icon: const Icon(Icons.home_outlined),
                        selectedIcon: const Icon(Icons.home),
                      ),
                      NavigationDestination(
                        label: AppLocalizations.of(context)!.accountsLabel,
                        icon: const Icon(Icons.credit_card_outlined),
                        selectedIcon: const Icon(Icons.credit_card),
                      ),
                      NavigationDestination(
                        label: AppLocalizations.of(context)!.categoryLabel,
                        icon: const Icon(Icons.category_outlined),
                        selectedIcon: const Icon(Icons.category),
                      ),
                      NavigationDestination(
                        label: AppLocalizations.of(context)!.budgetLabel,
                        icon: const Icon(Icons.account_balance_wallet_outlined),
                        selectedIcon: const Icon(Icons.account_balance_wallet),
                      ),
                      NavigationDestination(
                        label: AppLocalizations.of(context)!.debtsLabel,
                        icon: const Icon(MdiIcons.accountCashOutline),
                        selectedIcon: const Icon(MdiIcons.accountCash),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          desktop: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Row(
              children: [
                BlocBuilder(
                  bloc: homeBloc,
                  builder: (context, state) {
                    if (state is CurrentIndexState) {
                      return Drawer(
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width >= 700
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onLongPress: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const ColorPalette(),
                                          ),
                                        );
                                      },
                                      child: const WelcomeWidget(),
                                    ),
                                    const WelcomeNameWidget(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              NavigationBarItem(
                                title: AppLocalizations.of(context)!.homeLabel,
                                icon: Icons.home_outlined,
                                isSelected: state.currentPage == PaisaPage.home,
                                onPressed: () => homeBloc.add(
                                    const CurrentIndexEvent(PaisaPage.home)),
                              ),
                              NavigationBarItem(
                                title:
                                    AppLocalizations.of(context)!.accountsLabel,
                                icon: Icons.credit_card,
                                isSelected:
                                    state.currentPage == PaisaPage.accounts,
                                onPressed: () => homeBloc.add(
                                    const CurrentIndexEvent(
                                        PaisaPage.accounts)),
                              ),
                              NavigationBarItem(
                                title:
                                    AppLocalizations.of(context)!.categoryLabel,
                                icon: Icons.category,
                                isSelected:
                                    state.currentPage == PaisaPage.category,
                                onPressed: () => homeBloc.add(
                                    const CurrentIndexEvent(
                                        PaisaPage.category)),
                              ),
                              NavigationBarItem(
                                title:
                                    AppLocalizations.of(context)!.budgetLabel,
                                icon: Icons.account_balance_wallet,
                                isSelected: state.currentPage ==
                                    PaisaPage.budgetOverview,
                                onPressed: () => homeBloc.add(
                                    const CurrentIndexEvent(
                                        PaisaPage.budgetOverview)),
                              ),
                              NavigationBarItem(
                                title: AppLocalizations.of(context)!.debtsLabel,
                                icon: MdiIcons.accountCash,
                                isSelected:
                                    state.currentPage == PaisaPage.debts,
                                onPressed: () => homeBloc.add(
                                    const CurrentIndexEvent(PaisaPage.debts)),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                Expanded(
                    child: ContentWidget(
                  pages: _pages,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? Theme.of(context).colorScheme.onSecondaryContainer
        : Theme.of(context).textTheme.headline6?.color;
    return Padding(
      padding: const EdgeInsets.only(
        right: 12,
        bottom: 8,
        left: 8,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onPressed,
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(40),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                )
              : null,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Icon(icon, color: color),
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
    required this.pages,
  }) : super(key: key);

  final Map<PaisaPage, Widget> pages;

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
        }
        return SizedBox.fromSize();
      },
    );
  }
}
