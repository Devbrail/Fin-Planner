import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/src/presentation/overview/pages/overview_page.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../widgets/paisa_icon_title.dart';
import '../../widgets/paisa_search_button_widget.dart';
import '../../widgets/paisa_user_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/content_widget.dart';
import '../widgets/drawer_item_widget.dart';

class HomeMobilePage extends StatelessWidget {
  const HomeMobilePage({
    super.key,
    required this.homeBloc,
    required this.floatingActionButton,
  });

  final HomeBloc homeBloc;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PaisaTitle(),
        actions: [
          const PaisaSearchButtonWidget(),
          PaisaUserWidget(homeBloc: homeBloc),
          const SizedBox(width: 8),
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
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: PaisaIconTitle(),
                  ),
                  DrawerItemWidget(
                    isSelected: pageType == PageType.home,
                    onPressed: () {
                      homeBloc.add(const CurrentIndexEvent(PageType.home));
                      Navigator.pop(context);
                    },
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    title: context.loc.home,
                  ),
                  DrawerItemWidget(
                    isSelected: pageType == PageType.category,
                    onPressed: () {
                      homeBloc.add(const CurrentIndexEvent(PageType.category));
                      Navigator.pop(context);
                    },
                    icon: Icons.category_outlined,
                    selectedIcon: Icons.category,
                    title: context.loc.categories,
                  ),
                  DrawerItemWidget(
                    isSelected: pageType == PageType.budget,
                    onPressed: () {
                      homeBloc.add(const CurrentIndexEvent(PageType.budget));
                      Navigator.pop(context);
                    },
                    icon: MdiIcons.timetable,
                    selectedIcon: MdiIcons.timetable,
                    title: context.loc.budget,
                  ),
                  DrawerItemWidget(
                    isSelected: false,
                    onPressed: () {
                      Navigator.pop(context);
                      GoRouter.of(context).goNamed(recurringTransactionsName);
                    },
                    icon: MdiIcons.cashSync,
                    selectedIcon: MdiIcons.cashSync,
                    title: context.loc.recurring,
                  ),
                  const Divider(),
                  DrawerItemWidget(
                    isSelected: false,
                    onPressed: () {
                      GoRouter.of(context).goNamed(settingsPath);
                      Navigator.pop(context);
                    },
                    icon: MdiIcons.cog,
                    title: context.loc.settings,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: ContentWidget(),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: BlocBuilder(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is CurrentIndexState &&
              (state.currentPage == PageType.budget ||
                  state.currentPage == PageType.category)) {
            return const SizedBox.shrink();
          }
          return Theme(
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
                  label: context.loc.home,
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                ),
                NavigationDestination(
                  label: context.loc.accounts,
                  icon: const Icon(Icons.credit_card_outlined),
                  selectedIcon: const Icon(Icons.credit_card),
                ),
                NavigationDestination(
                  label: context.loc.debts,
                  icon: const Icon(MdiIcons.accountCashOutline),
                  selectedIcon: const Icon(MdiIcons.accountCash),
                ),
                NavigationDestination(
                  label: context.loc.overview,
                  icon: const Icon(MdiIcons.sortVariant),
                  selectedIcon: const Icon(MdiIcons.sortVariant),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
