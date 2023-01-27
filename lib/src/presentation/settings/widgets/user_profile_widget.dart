import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../service_locator.dart';
import '../../login/pages/user_image_page.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    Key? key,
    required this.settings,
    required this.nameController,
  }) : super(key: key);

  final Box<dynamic> settings;

  final TextEditingController nameController;

  void _updateDetails(BuildContext context) => settings
      .put(userNameKey, nameController.text)
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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  context.loc.profileLabel,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 16),
                  UserImageWidget(pickImage: () => _pickImage(context)),
                  Expanded(
                    child: UserTextField(nameController: nameController),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
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
                    context.loc.updateLabel,
                  ),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}

class UserTextField extends StatelessWidget {
  final TextEditingController nameController;

  const UserTextField({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: locator
          .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
          .listenable(keys: [userNameKey]),
      builder: (context, value, _) {
        nameController.text = value.get(userNameKey, defaultValue: 'Name');
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextFormField(
            autocorrect: true,
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: context.loc.userNameLabel,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              filled: true,
            ),
            validator: (value) {
              if (value!.length >= 3) {
                return null;
              } else {
                return context.loc.validNameLabel;
              }
            },
          ),
        );
      },
    );
  }
}
