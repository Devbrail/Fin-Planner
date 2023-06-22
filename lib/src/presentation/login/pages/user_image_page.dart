import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../widgets/paisa_user_image_widget.dart';

class UserImagePage extends StatefulWidget {
  const UserImagePage({Key? key}) : super(key: key);

  @override
  State<UserImagePage> createState() => _UserImagePageState();
}

class _UserImagePageState extends State<UserImagePage> {
  final Box<dynamic> value =
      getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);

  void _pickImage() {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        settings.put(userImageKey, pickedFile.path);
      }
    });
  }

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
                    context.primary,
                    BlendMode.srcIn,
                  ),
                  child: const Icon(
                    Icons.person_add_rounded,
                    size: 72,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.loc.image,
                  style: context.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.onSurface,
                  ),
                ),
                Text(
                  context.loc.imageDesc,
                  style: context.titleMedium?.copyWith(
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
                    useDefault: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final String image = value.get(userImageKey, defaultValue: '');
          if (image.isEmpty) {
            await value.put(userImageKey, 'no-image');
          }
          if (context.mounted) context.go(categorySelectorPath);
        },
        extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
        label: const Icon(MdiIcons.arrowRight),
        icon: Text(
          context.loc.next,
          style: context.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
