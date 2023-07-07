import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../widgets/paisa_icon_title.dart';
import '../../widgets/paisa_search_bar.dart';
import '../../widgets/paisa_user_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/content_widget.dart';
import 'home_page.dart';

class HomeDesktopPage extends StatelessWidget {
  const HomeDesktopPage({
    super.key,
    required this.floatingActionButton,
    required this.destinations,
  });

  final List<Destination> destinations;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: PaisaIconTitle(),
        ),
        leadingWidth: 300,
        title: const PaisaSearchBar(),
        actions: const [PaisaUserWidget()],
      ),
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return NavigationDrawer(
                elevation: 0,
                selectedIndex: homeBloc.selectedIndex,
                onDestinationSelected: (index) {
                  homeBloc.add(CurrentIndexEvent(index));
                },
                children: [
                  ...destinations
                      .map((e) => NavigationDrawerDestination(
                            icon: e.icon,
                            selectedIcon: e.selectedIcon,
                            label: Text(e.pageType.name(context)),
                          ))
                      .toList(),
                  const Divider(),
                  ListTile(
                    onTap: () => context.pushNamed(settingsName),
                    leading: Icon(
                      Icons.settings,
                      color: context.primary,
                    ),
                    title: Text(
                      context.loc.settings,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        textStyle: context.bodyLarge,
                        color: context.onBackground,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          const Expanded(
            child: SafeArea(
              child: ContentWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
