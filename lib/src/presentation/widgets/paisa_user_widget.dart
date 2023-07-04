import 'package:flutter/material.dart';

import '../../../main.dart';
import '../home/widgets/welcome_widget.dart';
import '../settings/controller/settings_controller.dart';
import '../settings/widgets/user_profile_widget.dart';
import 'color_palette.dart';

class PaisaUserWidget extends StatelessWidget {
  const PaisaUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {},
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
          maxWidth:
              MediaQuery.of(context).size.width >= 700 ? 700 : double.infinity,
        ),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (_) => UserProfilePage(
          settings: getIt.get<SettingsController>(),
          controller: TextEditingController(),
        ),
      ),
      child: const UserImageWidget(),
    );
  }
}
