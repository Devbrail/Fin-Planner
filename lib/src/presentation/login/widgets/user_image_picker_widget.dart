import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../../widgets/paisa_user_image_widget.dart';

class UserImagePickerWidget extends StatelessWidget {
  const UserImagePickerWidget({
    Key? key,
    @Named('settings') required this.settings,
  }) : super(key: key);

  final Box<dynamic> settings;

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
    return SafeArea(
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
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: PaisaUserImageWidget(
                pickImage: _pickImage,
                maxRadius: 72,
                useDefault: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
