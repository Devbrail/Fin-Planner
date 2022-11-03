part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class ExpenseInitial extends HomeState {}

class CurrentIndexState extends HomeState {
  final PaisaPage currentPage;

  CurrentIndexState(this.currentPage);
}
