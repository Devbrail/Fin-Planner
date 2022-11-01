import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../common/enum/box_types.dart';
import '../../../data/settings/settings_service.dart';
import '../pages/home_page.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(CurrentIndexState(PaisaPage.home)) {
    on<HomeEvent>((event, emit) {});
    on<UpdateUserDetailsEvent>(
        (event, emit) => _updateUserDetails(event, emit));
    on<PickImageEvent>((event, emit) => _pickImage(event, emit));
    on<CurrentIndexEvent>((event, emit) => _currentIndex(event, emit));
  }

  late final settings = Hive.box(BoxType.settings.stringValue);
  String selectedImage = '';
  PaisaPage currentPage = PaisaPage.home;

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
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = pickedFile.path;
      settings.put(userImageKey, selectedImage).then(
          (value) => add(UpdateUserDetailsEvent(imagePath: selectedImage)));
    }
  }

  void _currentIndex(CurrentIndexEvent event, Emitter<HomeState> emit) {
    if (currentPage != event.currentPage) {
      currentPage = event.currentPage;
      emit(CurrentIndexState(event.currentPage));
    }
  }

  int getIndexFromPage(PaisaPage currentPage) {
    switch (currentPage) {
      case PaisaPage.home:
        return 0;
      case PaisaPage.accounts:
        return 1;
      case PaisaPage.category:
        return 2;
      case PaisaPage.budgetOverview:
        return 3;
      case PaisaPage.debts:
        return 4;
    }
  }

  PaisaPage getPageFromIndex(int index) {
    switch (index) {
      case 1:
        return PaisaPage.accounts;
      case 2:
        return PaisaPage.category;
      case 3:
        return PaisaPage.budgetOverview;
      case 4:
        return PaisaPage.debts;
      case 0:
      default:
        return PaisaPage.home;
    }
  }
}
