import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';

class UserImagePage extends StatefulWidget {
  const UserImagePage({Key? key}) : super(key: key);

  @override
  State<UserImagePage> createState() => _UserImagePageState();
}

class _UserImagePageState extends State<UserImagePage> {
  final Box<dynamic> value =
      getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);

  void _pickImage() {
    if (Platform.isAndroid) {
      final ImagePicker picker = ImagePicker();
      picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
        if (pickedFile != null) {
          settings.put(userImageKey, pickedFile.path);
        }
      });
    } else {
      context
          .showMaterialSnackBar('Not supported in ${Platform.operatingSystem}');
    }
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
                  context.loc.imageLabel,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  context.loc.imageDescLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
        extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
        label: const Icon(MdiIcons.arrowRight),
        icon: Text(
          context.loc.nextLabel,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
        ),
      ),
    );
  }
}

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    Key? key,
    required this.pickImage,
    this.maxRadius,
  }) : super(key: key);

  final VoidCallback pickImage;
  final double? maxRadius;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: getIt
          .get<Box<dynamic>>(instanceName: BoxType.settings.name)
          .listenable(
        keys: [userImageKey],
      ),
      builder: (context, value, _) {
        String image = value.get(userImageKey, defaultValue: '');
        if (image == 'no-image') {
          image = '';
        }
        return GestureDetector(
          onTap: pickImage,
          child: Builder(
            builder: (context) {
              if (image.isEmpty) {
                return CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  maxRadius: maxRadius,
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                );
              } else {
                return CircleAvatar(
                  foregroundImage: FileImage(File(image)),
                  maxRadius: maxRadius,
                );
              }
            },
          ),
        );
      },
    );
  }
}
