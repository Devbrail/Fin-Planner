import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../login/pages/user_image_page.dart';
import '../../widgets/choose_theme_mode_widget.dart';
import '../../widgets/paisa_text_field.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    Key? key,
    required this.settings,
    required this.controller,
  }) : super(key: key);

  final Box<dynamic> settings;

  final TextEditingController controller;

  void _updateDetails(BuildContext context) => settings
      .put(userNameKey, controller.text)
      .then((value) => Navigator.pop(context));

  void _pickImage(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        settings
            .put(userImageKey, pickedFile.path)
            .then((value) => Navigator.pop(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = settings.get(userNameKey, defaultValue: '');
    controller.text = name;
    controller.selection = TextSelection.collapsed(offset: name.length);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                context.loc.profileLabel,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: IconButton(
                tooltip: context.loc.settingsLabel,
                onPressed: () {
                  context.pop();
                  GoRouter.of(context).pushNamed(settingsPath);
                },
                icon: Icon(
                  MdiIcons.cog,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 16),
                UserImageWidget(pickImage: () => _pickImage(context)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: PaisaTextFormField(
                      controller: controller,
                      hintText: 'Enter name',
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () => _updateDetails(context),
                child: Text(context.loc.updateLabel),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
