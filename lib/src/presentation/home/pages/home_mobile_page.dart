import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/src/presentation/summary/widgets/expense_total_widget.dart';
import 'package:flutter_paisa/src/presentation/summary/widgets/welcome_name_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../goal/widget/color_palette.dart';
import '../../search/pages/search_page.dart';
import '../../settings/widgets/user_profile_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/content_widget.dart';
import '../widgets/drawer_item_widget.dart';
import '../widgets/welcome_widget.dart';

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
        title: BlocBuilder(
          bloc: homeBloc,
          builder: (context, state) {
            if (state is CurrentIndexState) {
              return Text(
                state.currentPage.name(context),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              );
            }
            return const SizedBox.shrink();
          },
        ),
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
      drawer: Drawer(
        child: BlocBuilder(
          bloc: homeBloc,
          builder: (context, state) {
            PageType pageType = PageType.home;
            if (state is CurrentIndexState) {
              pageType = state.currentPage;
            }
            bool isSelected = pageType == PageType.debts;
            return ListView(
              children: [
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                DrawerItemWidget(
                  isSelected: isSelected,
                  onPressed: () {
                    homeBloc.add(const CurrentIndexEvent(PageType.debts));
                    Navigator.pop(context);
                  },
                  icon: MdiIcons.accountCashOutline,
                  title: AppLocalizations.of(context)!.debtsLabel,
                ),
                DrawerItemWidget(
                  isSelected: false,
                  onPressed: () {
                    GoRouter.of(context).pushNamed(settingsPath);
                    Navigator.pop(context);
                  },
                  icon: MdiIcons.cog,
                  title: AppLocalizations.of(context)!.settingsLabel,
                ),
              ],
            );
          },
        ),
      ),
      body: ContentWidget(dateTimeRangeNotifier: dateTimeRangeNotifier),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: BlocBuilder(
        bloc: homeBloc,
        builder: (context, state) {
          return Theme(
            data: Theme.of(context)
                .copyWith(splashFactory: NoSplash.splashFactory),
            child: NavigationBar(
              selectedIndex: homeBloc.getIndexFromPage(homeBloc.currentPage),
              onDestinationSelected: (index) => homeBloc
                  .add(CurrentIndexEvent(homeBloc.getPageFromIndex(index))),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
