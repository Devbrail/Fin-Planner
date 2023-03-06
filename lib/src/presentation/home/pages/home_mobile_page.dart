import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../widgets/choose_theme_mode_widget.dart';
import '../../widgets/filter_widget/paisa_filter_transaction_widget.dart';
import '../../widgets/paisa_search_button_widget.dart';
import '../../widgets/paisa_title_widget.dart';
import '../../widgets/paisa_user_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/content_widget.dart';
import '../widgets/drawer_item_widget.dart';

class HomeMobilePage extends StatelessWidget {
  const HomeMobilePage({
    super.key,
    required this.homeBloc,
    required this.dateTimeRangeNotifier,
    required this.floatingActionButton,
  });
  final HomeBloc homeBloc;
  final Widget floatingActionButton;
  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PaisaTitleWidget(),
        actions: [
          const PaisaFilterTransactionWidget(),
          const PaisaSearchButtonWidget(),
          PaisaUserWidget(
            homeBloc: homeBloc,
          ),
        ],
      ),
      drawer: Drawer(
        child: BlocBuilder(
          bloc: homeBloc,
          builder: (context, state) {
            bool isSelected = false;
            if (state is CurrentIndexState) {
              isSelected = state.currentPage == PageType.debts;
            }
            return ListView(
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.wallet,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  title: Text(
                    context.loc.appTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                DrawerItemWidget(
                  isSelected: isSelected,
                  onPressed: () {
                    homeBloc.add(const CurrentIndexEvent(PageType.debts));
                    Navigator.pop(context);
                  },
                  icon: MdiIcons.accountCashOutline,
                  title: context.loc.debtsLabel,
                ),
                const Divider(),
                DrawerItemWidget(
                  isSelected: false,
                  onPressed: () async {
                    context.pop();
                    await showModalBottomSheet(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width >= 700
                            ? 700
                            : double.infinity,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      context: context,
                      builder: (_) => ChooseThemeModeWidget(
                        currentTheme: ThemeMode.values[
                            settings.get(themeModeKey, defaultValue: 0)],
                      ),
                    );
                  },
                  icon: MdiIcons.brightness4,
                  title: context.loc.chooseThemeLabel,
                ),
                DrawerItemWidget(
                  isSelected: false,
                  onPressed: () {
                    GoRouter.of(context).pushNamed(settingsPath);
                    Navigator.pop(context);
                  },
                  icon: MdiIcons.cog,
                  title: context.loc.settingsLabel,
                ),
              ],
            );
          },
        ),
      ),
      body: ContentWidget(
        dateTimeRangeNotifier: dateTimeRangeNotifier,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: BlocBuilder(
        bloc: homeBloc,
        builder: (context, state) => Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
          ),
          child: NavigationBar(
            elevation: 1,
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedIndex: homeBloc.getIndexFromPage(homeBloc.currentPage),
            onDestinationSelected: (index) => homeBloc
                .add(CurrentIndexEvent(homeBloc.getPageFromIndex(index))),
            destinations: [
              NavigationDestination(
                label: context.loc.homeLabel,
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
              ),
              NavigationDestination(
                label: context.loc.accountsLabel,
                icon: const Icon(Icons.credit_card_outlined),
                selectedIcon: const Icon(Icons.credit_card),
              ),
              NavigationDestination(
                label: context.loc.categoryLabel,
                icon: const Icon(Icons.category_outlined),
                selectedIcon: const Icon(Icons.category),
              ),
              NavigationDestination(
                label: context.loc.budgetLabel,
                icon: const Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: const Icon(Icons.account_balance_wallet),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
