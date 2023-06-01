import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/presentation/widgets/paisa_annotate_region_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_floating_action_button_widget.dart';
import 'home_desktop_widget.dart';
import 'home_mobile_page.dart';
import 'home_tablet_page.dart';

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
            if (homeBloc.currentPage == PageType.home) {
              return true;
            }
            homeBloc.add(const CurrentIndexEvent(PageType.home));
            return false;
          },
          child: ScreenTypeLayout(
            breakpoints: const ScreenBreakpoints(
              tablet: 600,
              desktop: 700,
              watch: 300,
            ),
            mobile: HomeMobilePage(
              homeBloc: homeBloc,
              floatingActionButton: actionButton,
            ),
            tablet: HomeTabletPage(
              homeBloc: homeBloc,
              floatingActionButton: actionButton,
            ),
            desktop: HomeDesktopWidget(
              homeBloc: homeBloc,
              floatingActionButton: actionButton,
            ),
          ),
        ),
      ),
    );
  }
}
