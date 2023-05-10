import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/core/enum/box_types.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../settings/bloc/settings_controller.dart';
import '../../summary/controller/summary_controller.dart';
import '../bloc/home_bloc.dart';
import '../widgets/floating_action_button_widget.dart';
import 'home_desktop_widget.dart';
import 'home_mobile_page.dart';
import 'home_tablet_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final HomeBloc homeBloc = getIt.get<HomeBloc>();
  final SettingsController settingsController = getIt.get();
  final SummaryController summaryController = getIt.get();

  @override
  Widget build(BuildContext context) {
    final actionButton = PaisaActionButton(
      summaryController: getIt.get(),
      settings: getIt.get<Box<dynamic>>(
        instanceName: BoxType.settings.name,
      ),
    );
    return BlocProvider(
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
    );
  }
}
