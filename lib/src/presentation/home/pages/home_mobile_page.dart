import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../widgets/filter_widget/paisa_filter_transaction_widget.dart';
import '../../widgets/paisa_icon_title.dart';
import '../../widgets/paisa_search_button_widget.dart';
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
        actions: const [
          PaisaFilterTransactionWidget(),
          PaisaSearchButtonWidget(),
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
                    title: context.loc.homeLabel,
                  ),
                  DrawerItemWidget(
                    isSelected: pageType == PageType.category,
                    onPressed: () {
                      homeBloc.add(const CurrentIndexEvent(PageType.category));
                      Navigator.pop(context);
                    },
                    icon: Icons.category_outlined,
                    selectedIcon: Icons.category,
                    title: context.loc.categoriesLabel,
                  ),
                  DrawerItemWidget(
                    isSelected: pageType == PageType.budget,
                    onPressed: () {
                      homeBloc.add(const CurrentIndexEvent(PageType.budget));
                      Navigator.pop(context);
                    },
                    icon: MdiIcons.timetable,
                    selectedIcon: MdiIcons.timetable,
                    title: context.loc.budgetLabel,
                  ),
                  const Divider(),
                  DrawerItemWidget(
                    isSelected: false,
                    onPressed: () {
                      GoRouter.of(context).goNamed(settingsPath);
                      Navigator.pop(context);
                    },
                    icon: MdiIcons.cog,
                    title: context.loc.settingsLabel,
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
                  label: context.loc.debtsLabel,
                  icon: const Icon(MdiIcons.accountCashOutline),
                  selectedIcon: const Icon(MdiIcons.accountCash),
                ),
                NavigationDestination(
                  label: context.loc.overviewLabel,
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
