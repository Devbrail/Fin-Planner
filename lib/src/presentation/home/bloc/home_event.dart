part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class CurrentIndexEvent extends HomeEvent {
  final PaisaPage currentPage;

  const CurrentIndexEvent(this.currentPage);

  @override
  List<Object?> get props => [currentPage];
}
