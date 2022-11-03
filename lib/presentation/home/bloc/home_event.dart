part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class CurrentIndexEvent extends HomeEvent {
  final PaisaPage currentPage;

  CurrentIndexEvent(this.currentPage);
}
