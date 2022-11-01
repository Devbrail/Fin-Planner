import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../di/service_locator.dart';
import '../../accounts/pages/accounts_page.dart';
import '../../budget_overview/pages/budget_overview_page.dart';
import '../../category/pages/category_list_page.dart';
import '../../debits/pages/debts_page.dart';
import '../../summary/pages/summary_page.dart';
import '../bloc/home_bloc.dart';
import '../widgets/welcome_widget.dart';

enum PaisaPage { home, accounts, category, budgetOverview, debts }

final Map<PaisaPage, Widget> _pages = {
  PaisaPage.home: const SummaryPage(key: Key('home_page')),
  PaisaPage.accounts: const AccountsPage(key: Key('accounts_page')),
  PaisaPage.category: const CategoryListPage(key: Key('category_page')),
  PaisaPage.budgetOverview: const BudgetOverViewPage(key: Key('budget_page')),
  PaisaPage.debts: const DebtsPage(key: Key('settings_page')),
};

class LandingPage extends StatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late final HomeBloc homeBloc = locator.get<HomeBloc>();

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
      default:
    }
  }

  Widget _floatingActionButtonBig() {
    return BlocBuilder(
      bloc: homeBloc,
      builder: (context, state) {
        return state is CurrentIndexState &&
                state.currentPage != PaisaPage.budgetOverview
            ? FloatingActionButton.large(
                onPressed: () => _handleClick(state.currentPage),
                tooltip: AppLocalizations.of(context)!.addExpenseLabel,
                heroTag: 'add_expense',
                key: const Key('add_expense'),
                child: const Icon(Icons.add),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _floatingActionButton() {
    return BlocBuilder(
      bloc: homeBloc,
      builder: (context, state) {
        return state is CurrentIndexState &&
                state.currentPage != PaisaPage.budgetOverview
            ? FloatingActionButton(
                onPressed: () => _handleClick(state.currentPage),
                tooltip: AppLocalizations.of(context)!.addExpenseLabel,
                heroTag: 'add_expense',
                key: const Key('add_expense'),
                child: const Icon(Icons.add),
              )
            : const SizedBox.shrink();
      },
    );
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
          homeBloc.add(CurrentIndexEvent(PaisaPage.home));
          return false;
        },
        child: ScreenTypeLayout(
          breakpoints: const ScreenBreakpoints(
            tablet: 600,
            desktop: 700,
            watch: 300,
          ),
          mobile: Scaffold(
            body: const ContentWidget(),
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
                        child: ListView(
                          children: [
                            ListTile(
                              title: Text('Header'),
                            ),
                            NavigationBarItem(
                              title: AppLocalizations.of(context)!.homeLabel,
                              icon: Icons.home_outlined,
                              isSelected: state.currentPage == PaisaPage.home,
                              onPressed: () => homeBloc
                                  .add(CurrentIndexEvent(PaisaPage.home)),
                            ),
                            NavigationBarItem(
                              title:
                                  AppLocalizations.of(context)!.accountsLabel,
                              icon: Icons.credit_card,
                              isSelected:
                                  state.currentPage == PaisaPage.accounts,
                              onPressed: () => homeBloc
                                  .add(CurrentIndexEvent(PaisaPage.accounts)),
                            ),
                            NavigationBarItem(
                              title:
                                  AppLocalizations.of(context)!.categoryLabel,
                              icon: Icons.category,
                              isSelected:
                                  state.currentPage == PaisaPage.category,
                              onPressed: () => homeBloc
                                  .add(CurrentIndexEvent(PaisaPage.category)),
                            ),
                            NavigationBarItem(
                              title: AppLocalizations.of(context)!.budgetLabel,
                              icon: Icons.account_balance_wallet,
                              isSelected:
                                  state.currentPage == PaisaPage.budgetOverview,
                              onPressed: () => homeBloc.add(
                                  CurrentIndexEvent(PaisaPage.budgetOverview)),
                            ),
                            NavigationBarItem(
                              title: AppLocalizations.of(context)!.debtsLabel,
                              icon: MdiIcons.accountCash,
                              isSelected: state.currentPage == PaisaPage.debts,
                              onPressed: () => homeBloc
                                  .add(CurrentIndexEvent(PaisaPage.debts)),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                    return NavigationRail(
                      selectedIndex:
                          homeBloc.getIndexFromPage(homeBloc.currentPage),
                      onDestinationSelected: (index) => homeBloc.add(
                          CurrentIndexEvent(homeBloc.getPageFromIndex(index))),
                      groupAlignment: 1,
                      extended: true,
                      leading: SafeArea(
                        child: Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: _floatingActionButton(),
                          ),
                        ),
                      ),
                      trailing: const Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: WelcomeWidget(),
                        ),
                      ),
                      selectedLabelTextStyle:
                          Theme.of(context).textTheme.subtitle1?.copyWith(),
                      unselectedLabelTextStyle:
                          Theme.of(context).textTheme.subtitle1?.copyWith(),
                      destinations: [
                        NavigationRailDestination(
                          label: Text(AppLocalizations.of(context)!.homeLabel),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          icon: const Icon(Icons.home_outlined),
                          selectedIcon: const Icon(Icons.home),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(Icons.credit_card_outlined),
                          selectedIcon: const Icon(Icons.credit_card),
                          label:
                              Text(AppLocalizations.of(context)!.accountsLabel),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(Icons.category_outlined),
                          selectedIcon: const Icon(Icons.category),
                          label:
                              Text(AppLocalizations.of(context)!.categoryLabel),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                        ),
                        NavigationRailDestination(
                          icon:
                              const Icon(Icons.account_balance_wallet_outlined),
                          selectedIcon:
                              const Icon(Icons.account_balance_wallet),
                          label:
                              Text(AppLocalizations.of(context)!.budgetLabel),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(MdiIcons.accountCashOutline),
                          selectedIcon: const Icon(MdiIcons.accountCash),
                          label: Text(AppLocalizations.of(context)!.debtsLabel),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SafeArea(child: VerticalDivider(thickness: 1, width: 1)),
                const Expanded(child: ContentWidget()),
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
    return Padding(
      padding: const EdgeInsets.only(
        right: 12,
        bottom: 8,
        left: 8,
        top: 8,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onPressed,
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                )
              : null,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(icon),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentWidget extends StatefulWidget {
  const ContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
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
            child: _pages[state.currentPage],
          );
        }
        return SizedBox.fromSize();
      },
    );
  }
}
