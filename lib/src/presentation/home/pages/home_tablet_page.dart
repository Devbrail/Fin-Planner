import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../widgets/paisa_icon_title.dart';
import '../../widgets/paisa_search_bar.dart';
import '../../widgets/paisa_user_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/content_widget.dart';

class HomeTabletPage extends StatelessWidget {
  const HomeTabletPage({
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
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: PaisaIcon(),
        ),
        leadingWidth: 86,
        title: const PaisaSearchBar(),
        actions: [
          PaisaUserWidget(
            homeBloc: homeBloc,
          ),
        ],
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return NavigationRail(
                elevation: 1,
                selectedLabelTextStyle: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelTextStyle: context.bodyLarge,
                labelType: NavigationRailLabelType.all,
                backgroundColor: context.surface,
                selectedIndex: homeBloc.getIndexFromPage(homeBloc.currentPage),
                onDestinationSelected: (index) {
                  switch (index) {
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                      homeBloc.add(
                          CurrentIndexEvent(homeBloc.getPageFromIndex(index)));

                      break;
                    case 6:
                      GoRouter.of(context).pushNamed(settingsPath);
                      break;
                    default:
                  }
                },
                destinations: [
                  NavigationRailDestination(
                    label: Text(context.loc.home),
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon: const Icon(Icons.home),
                  ),
                  NavigationRailDestination(
                    label: Text(context.loc.accounts),
                    icon: const Icon(Icons.credit_card_outlined),
                    selectedIcon: const Icon(Icons.credit_card),
                  ),
                  NavigationRailDestination(
                    label: Text(context.loc.debts),
                    icon: const Icon(MdiIcons.accountCash),
                    selectedIcon: const Icon(MdiIcons.accountCashOutline),
                  ),
                  NavigationRailDestination(
                    label: Text(context.loc.overview),
                    icon: const Icon(MdiIcons.sortVariant),
                    selectedIcon: const Icon(MdiIcons.sortVariant),
                  ),
                  NavigationRailDestination(
                    label: Text(context.loc.categories),
                    icon: const Icon(Icons.category_outlined),
                    selectedIcon: const Icon(Icons.category),
                  ),
                  NavigationRailDestination(
                    label: Text(context.loc.budget),
                    icon: const Icon(MdiIcons.timetable),
                    selectedIcon: const Icon(MdiIcons.timetable),
                  ),
                  NavigationRailDestination(
                    label: Text(context.loc.settings),
                    icon: const Icon(MdiIcons.cog),
                    selectedIcon: const Icon(MdiIcons.cog),
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: ContentWidget(),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
