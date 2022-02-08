import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../data/splash_screen/datasource/splash_local_data_sources.dart';
import '../../../domain/landing/usecase/expense_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.expenseUseCase,
    required this.splashDataSource,
  }) : super(ExpenseInitial()) {
    on<HomeEvent>((event, emit) {});
    on<ClearExpesensesEvent>((event, emit) => _clearExpenses(emit));
    on<UpdateUserDetailsEvent>(
        (event, emit) => _updateUserDetails(event, emit));
    on<FetchUserDetailsEvent>((event, emit) => _fetchUserDetails(emit));
    on<PickImageEvent>((event, emit) => _pickImage(event, emit));
  }

  String selectedImage = '';
  final ExpenseUseCase expenseUseCase;
  final SplashLocalDataSource splashDataSource;

  Future<void> _clearExpenses(Emitter<HomeState> emit) async {
    await expenseUseCase.clearExpenses();
  }

  void _updateUserDetails(
    UpdateUserDetailsEvent event,
    Emitter<HomeState> emit,
  ) {
    if (event.name != null) {
      final String name = event.name!;
      splashDataSource.setName(name);
      emit(UserDetailsUpdatedState());
      emit(UserDetailsChangedState(name, selectedImage));
    }
  }

  Future<void> _fetchUserDetails(Emitter<HomeState> emit) async {
    final name = await splashDataSource.getName();
    selectedImage = await splashDataSource.getImage();
    emit(UserDetailsChangedState(name, selectedImage));
  }

  Future<void> _pickImage(PickImageEvent event, Emitter<HomeState> emit) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = pickedFile.path;
      splashDataSource.setImage(selectedImage);
      add(UpdateUserDetailsEvent(imagePath: selectedImage));
    }
  }
}

double validDate(String amount) {
  double amountInt = double.parse(amount);
  return amountInt;
}
