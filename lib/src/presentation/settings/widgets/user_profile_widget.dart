import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/common.dart';
import '../../widgets/paisa_text_field.dart';
import '../../widgets/paisa_user_image_widget.dart';
import '../controller/settings_controller.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    Key? key,
    required this.settings,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final SettingsController settings;

  void _updateDetails(BuildContext context) {
    String name = controller.text;
    settings.put(userNameKey, name).then((value) => Navigator.pop(context));
  }

  void _pickImage(BuildContext context) {
    if (Platform.isAndroid) {
      final ImagePicker picker = ImagePicker();
      picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
        if (pickedFile != null) {
          settings
              .put(userImageKey, pickedFile.path)
              .then((value) => Navigator.pop(context));
        }
      });
    } else {
      context
          .showMaterialSnackBar('Not supported in ${Platform.operatingSystem}');
    }
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
                context.loc.profile,
                style: context.titleLarge,
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 16),
                PaisaUserImageWidget(pickImage: () => _pickImage(context)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: PaisaTextFormField(
                      controller: controller,
                      hintText: 'Enter name',
                      keyboardType: TextInputType.name,
                      onChanged: (value) {},
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
                child: Text(
                  context.loc.update,
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
