part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class UpdateUserDetailsEvent extends HomeEvent {
  final String? name;
  final String? imagePath;

  UpdateUserDetailsEvent({
    this.name,
    this.imagePath,
  });
}

class PickImageEvent extends HomeEvent {}

class CurrentIndexEvent extends HomeEvent {
  final PaisaPage currentPage;

  CurrentIndexEvent(this.currentPage);
}
