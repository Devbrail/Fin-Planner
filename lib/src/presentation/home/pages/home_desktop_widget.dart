import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../main.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../settings/widgets/user_profile_widget.dart';
import '../../summary/widgets/welcome_name_widget.dart';
import '../../widgets/color_palette.dart';
import '../../widgets/filter_widget/paisa_filter_transaction_widget.dart';
import '../../widgets/paisa_search_bar.dart';
import '../bloc/home_bloc.dart';
import '../widgets/content_widget.dart';
import '../widgets/desktop_drawer_item_widget.dart';
import '../widgets/welcome_widget.dart';

class HomeDesktopWidget extends StatelessWidget {
  const HomeDesktopWidget({
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
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          BlocBuilder(
            bloc: homeBloc,
            builder: (context, state) {
              if (state is CurrentIndexState) {
                return Drawer(
                  elevation: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenTypeLayout.builder(
                        mobile: (_) => const SizedBox(height: kToolbarHeight),
                        tablet: (_) => const SizedBox(height: 32),
                        desktop: (_) => const SizedBox(height: kToolbarHeight),
                      ),
                      ListTile(
                        title: Text(
                          context.loc.appTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      NavigationBarItem(
                        title: context.loc.homeLabel,
                        icon: MdiIcons.home,
                        isSelected: state.currentPage == PageType.home,
                        onPressed: () => homeBloc
                            .add(const CurrentIndexEvent(PageType.home)),
                      ),
                      NavigationBarItem(
                        title: context.loc.accountsLabel,
                        icon: MdiIcons.creditCard,
                        isSelected: state.currentPage == PageType.accounts,
                        onPressed: () => homeBloc
                            .add(const CurrentIndexEvent(PageType.accounts)),
                      ),
                      NavigationBarItem(
                        title: context.loc.categoryLabel,
                        icon: Icons.category,
                        isSelected: state.currentPage == PageType.category,
                        onPressed: () => homeBloc
                            .add(const CurrentIndexEvent(PageType.category)),
                      ),
                      NavigationBarItem(
                        title: context.loc.budgetLabel,
                        icon: MdiIcons.wallet,
                        isSelected:
                            state.currentPage == PageType.budgetOverview,
                        onPressed: () => homeBloc.add(
                            const CurrentIndexEvent(PageType.budgetOverview)),
                      ),
                      NavigationBarItem(
                        title: context.loc.debtsLabel,
                        icon: MdiIcons.accountCash,
                        isSelected: state.currentPage == PageType.debts,
                        onPressed: () => homeBloc
                            .add(const CurrentIndexEvent(PageType.debts)),
                      ),
                      const Divider(),
                      NavigationBarItem(
                        title: context.loc.settingsLabel,
                        icon: MdiIcons.cog,
                        isSelected: false,
                        onPressed: () =>
                            GoRouter.of(context).pushNamed(settingsPath),
                      )
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const VerticalDivider(width: 0),
          Expanded(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
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
                          builder: (_) => UserProfilePage(
                            settings: getIt.get<Box<dynamic>>(
                              instanceName: BoxType.settings.name,
                            ),
                            controller: TextEditingController(),
                          ),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ColorPalette(),
                                  ),
                                );
                              },
                              child: const WelcomeWidget(),
                            ),
                            const WelcomeNameWidget(),
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          PaisaFilterTransactionWidget(),
                          PaisaSearchBar(),
                          SizedBox(width: 24),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ContentWidget(
                      dateTimeRangeNotifier: dateTimeRangeNotifier,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
