import 'package:bloc/bloc.dart';
import 'package:flutter_paisa/common/enum/box_types.dart';
import 'package:flutter_paisa/data/settings/settings_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(ExpenseInitial()) {
    on<HomeEvent>((event, emit) {});
    on<UpdateUserDetailsEvent>(
        (event, emit) => _updateUserDetails(event, emit));
    on<PickImageEvent>((event, emit) => _pickImage(event, emit));
  }

  late final settings = Hive.box(BoxType.settings.stringValue);
  String selectedImage = '';

  void _updateUserDetails(
    UpdateUserDetailsEvent event,
    Emitter<HomeState> emit,
  ) {
    if (event.name != null) {
      final String name = event.name!;
      settings.put(userNameKey, name);
    }
  }

  Future<void> _pickImage(PickImageEvent event, Emitter<HomeState> emit) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = pickedFile.path;
      settings.put(userImageKey, selectedImage);
      add(UpdateUserDetailsEvent(imagePath: selectedImage));
    }
  }
}
