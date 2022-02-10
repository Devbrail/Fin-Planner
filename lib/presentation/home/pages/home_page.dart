import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../accounts/pages/accounts_page.dart';
import '../../budget_overview/pages/budget_overview_page.dart';
import '../../category/pages/category_list_page.dart';
import '../../settings/pages/setting_page.dart';
import '../../summary/pages/summary_page.dart';
import '../widgets/welcome_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (index == 0) {
          return true;
        }
        setState(() {
          index = 0;
        });
        return false;
      },
      child: ScreenTypeLayout(
        mobile: Scaffold(
          body: ContentWidget(index: index),
          bottomNavigationBar: Material(
            elevation: 6,
            child: NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (index) {
                this.index = index;
                setState(() {});
              },
              destinations: [
                NavigationDestination(
                  label: AppLocalizations.of(context)!.home,
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                ),
                NavigationDestination(
                  label: AppLocalizations.of(context)!.accounts,
                  icon: const Icon(Icons.credit_card_outlined),
                  selectedIcon: const Icon(Icons.credit_card),
                ),
                NavigationDestination(
                  label: AppLocalizations.of(context)!.category,
                  icon: const Icon(Icons.category_outlined),
                  selectedIcon: const Icon(Icons.category),
                ),
                NavigationDestination(
                  label: AppLocalizations.of(context)!.budget,
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  selectedIcon: const Icon(Icons.account_balance_wallet),
                ),
                NavigationDestination(
                  label: AppLocalizations.of(context)!.settings,
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ),
        tablet: Scaffold(
          body: Row(
            children: [
              NavigationRail(
                labelType: NavigationRailLabelType.none,
                useIndicator: true,
                groupAlignment: -1,
                leading: const WelcomeWidget(),
                selectedLabelTextStyle: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelTextStyle: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                selectedIndex: index,
                onDestinationSelected: (index) {
                  this.index = index;
                  setState(() {});
                },
                destinations: [
                  NavigationRailDestination(
                    label: Text(AppLocalizations.of(context)!.home),
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon: const Icon(Icons.home),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.credit_card_outlined),
                    selectedIcon: const Icon(Icons.credit_card),
                    label: Text(AppLocalizations.of(context)!.accounts),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.category_outlined),
                    selectedIcon: const Icon(Icons.category),
                    label: Text(AppLocalizations.of(context)!.category),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.account_balance_wallet_outlined),
                    selectedIcon: const Icon(Icons.account_balance_wallet),
                    label: Text(AppLocalizations.of(context)!.budget),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    label: Text(AppLocalizations.of(context)!.settings),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: ContentWidget(index: index),
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
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
      duration: const Duration(milliseconds: 300),
      child: const [
        SummaryPage(key: Key('home_page')),
        AccountsPage(key: Key('accounts_page')),
        CategoryListPage(key: Key('category_page')),
        BudgetOverViewPage(key: Key('budget_page')),
        SettingsPage(key: Key('settings_page')),
      ][widget.index],
    );
  }
}
