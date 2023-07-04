import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../widgets/paisa_annotate_region_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_floating_action_button_widget.dart';
import 'home_desktop_page.dart';
import 'home_mobile_page.dart';
import 'home_tablet_page.dart';

final destinations = [
  Destination(
    pageType: PageType.home,
    icon: const Icon(Icons.home_outlined),
    selectedIcon: const Icon(Icons.home),
  ),
  Destination(
    pageType: PageType.accounts,
    icon: const Icon(Icons.credit_card_outlined),
    selectedIcon: const Icon(Icons.credit_card),
  ),
  Destination(
    pageType: PageType.debts,
    icon: const Icon(MdiIcons.accountCashOutline),
    selectedIcon: const Icon(MdiIcons.accountCash),
  ),
  Destination(
    pageType: PageType.overview,
    icon: const Icon(MdiIcons.sortVariant),
    selectedIcon: const Icon(MdiIcons.sortVariant),
  ),
  Destination(
    pageType: PageType.category,
    icon: const Icon(Icons.category_outlined),
    selectedIcon: const Icon(Icons.category),
  ),
  Destination(
    pageType: PageType.budget,
    icon: const Icon(MdiIcons.timetable),
    selectedIcon: const Icon(MdiIcons.timetable),
  ),
  Destination(
    pageType: PageType.recurring,
    icon: const Icon(MdiIcons.cashSync),
    selectedIcon: const Icon(MdiIcons.cashSync),
  ),
];

class LandingPage extends StatelessWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    final actionButton = HomeFloatingActionButtonWidget(
      summaryController: getIt.get(),
      settings: getIt.get<Box<dynamic>>(
        instanceName: BoxType.settings.name,
      ),
    );
    return PaisaAnnotatedRegionWidget(
      child: BlocProvider(
        create: (context) => homeBloc,
        child: WillPopScope(
          onWillPop: () async {
            if (homeBloc.selectedIndex == 0) {
              return true;
            }
            homeBloc.add(const CurrentIndexEvent(0));
            return false;
          },
          child: ScreenTypeLayout(
            mobile: HomeMobilePage(
              floatingActionButton: actionButton,
              destinations: destinations,
            ),
            tablet: HomeTabletPage(
              floatingActionButton: actionButton,
              destinations: destinations,
            ),
            desktop: HomeDesktopPage(
              floatingActionButton: actionButton,
              destinations: destinations,
            ),
          ),
        ),
      ),
    );
  }
}

class Destination {
  Destination({
    required this.pageType,
    required this.icon,
    required this.selectedIcon,
  });

  final Icon icon;
  final PageType pageType;
  final Icon selectedIcon;
}
