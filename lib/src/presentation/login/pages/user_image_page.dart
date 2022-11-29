import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../common/enum/box_types.dart';
import '../../../data/settings/settings_service.dart';
import '../../../di/service_locator.dart';
import '../../settings/cubit/user_image_cubit.dart';
import '../../settings/widgets/user_profile_widget.dart';

class UserImagePage extends StatefulWidget {
  const UserImagePage({Key? key}) : super(key: key);

  @override
  State<UserImagePage> createState() => _UserImagePageState();
}

class _UserImagePageState extends State<UserImagePage> {
  late final UserNameImageCubit nameImageCubit = locator.get();
  late final value = Hive.box(BoxType.settings.stringValue);

  void _pickImage() => nameImageCubit.pickImage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                  child: const Icon(
                    Icons.person_add_rounded,
                    size: 72,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.imageLabel,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  AppLocalizations.of(context)!.imageDescLabel,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.75),
                      ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: UserImageWidget(
                    pickImage: _pickImage,
                    maxRadius: 72,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final String image = value.get(userImageKey, defaultValue: '');
          if (image.isEmpty) {
            value.put(userImageKey, 'no-image');
          }
          context.go(splashPath);
        },
        label: Text(AppLocalizations.of(context)!.nextLabel),
        icon: const Icon(MdiIcons.arrowRight),
      ),
    );
  }
}
