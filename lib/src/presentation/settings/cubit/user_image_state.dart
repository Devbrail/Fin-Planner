part of 'user_image_cubit.dart';

abstract class UserImageState extends Equatable {
  const UserImageState();

  @override
  List<Object> get props => [];
}

class UserImageInitial extends UserImageState {}

class UserDetailsUpdatedState extends UserImageState {}
