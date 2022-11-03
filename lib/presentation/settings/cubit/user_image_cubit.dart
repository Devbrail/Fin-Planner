import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_paisa/common/enum/box_types.dart';
import 'package:flutter_paisa/data/settings/settings_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

part 'user_image_state.dart';

class UserNameImageCubit extends Cubit<UserImageState> {
  UserNameImageCubit() : super(UserImageInitial());
  late final settings = Hive.box(BoxType.settings.stringValue);
  String selectedImage = '';

  void pickImage() {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        selectedImage = pickedFile.path;
        settings.put(userImageKey, selectedImage);
      }
    });
  }

  void updateUserDetails(String name) {
    settings.put(userNameKey, name);
  }
}
