import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/app/routes.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/core/enum/page_type.dart';
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart';
import 'package:paisa/src/presentation/widgets/choose_theme_mode_widget.dart';
import 'package:paisa/src/presentation/widgets/paisa_bottom_sheet.dart';

import '../../core/enum/box_types.dart';
import '../../service_locator.dart';
import '../home/widgets/welcome_widget.dart';
import '../settings/widgets/user_profile_widget.dart';
import 'color_palette.dart';

class PaisaUserWidget extends StatelessWidget {
  const PaisaUserWidget({
    super.key,
    required this.homeBloc,
  });

  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ColorPalette(),
          ),
        );
      },
      onTap: () {
        showUserDialog(
          context,
          userMenuPopup: (userMenuPopup) async {
            switch (userMenuPopup) {
              case UserMenuPopup.debts:
                homeBloc.add(const CurrentIndexEvent(PageType.debts));
                Navigator.of(context).pop();
                break;
              case UserMenuPopup.chooseTheme:
                Navigator.of(context).pop();
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
                    currentTheme: ThemeMode
                        .values[settings.get(themeModeKey, defaultValue: 0)],
                  ),
                );
                break;
              case UserMenuPopup.settings:
                Navigator.of(context).pop();
                GoRouter.of(context).pushNamed(settingsPath);
                break;
            }
          },
        );
        /* showModalBottomSheet(
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
            settings: locator.get<Box<dynamic>>(
              instanceName: BoxType.settings.name,
            ),
            nameController: TextEditingController(),
          ),
        ); */
      },
      child: const WelcomeWidget(),
    );
  }
}
