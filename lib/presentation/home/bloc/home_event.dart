part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class ClearExpesensesEvent extends HomeEvent {}

class UpdateUserDetailsEvent extends HomeEvent {
  final String? name;
  final String? imagePath;

  UpdateUserDetailsEvent({
    this.name,
    this.imagePath,
  });
}

class FetchUserDetailsEvent extends HomeEvent {}

class PickImageEvent extends HomeEvent {}
