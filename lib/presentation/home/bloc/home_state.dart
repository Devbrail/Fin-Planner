part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class ExpenseInitial extends HomeState {}

class UserDetailsChangedState extends HomeState {
  final String name;
  final String image;
  UserDetailsChangedState(
    this.name,
    this.image,
  );
}

class UserDetailsUpdatedState extends HomeState {}
