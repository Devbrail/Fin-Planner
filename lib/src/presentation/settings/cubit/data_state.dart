part of 'data_cubit.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataSuccess extends DataState {}

class DataLoading extends DataState {}

class DataError extends DataState {
  final String error;

  const DataError(this.error);

  @override
  List<Object> get props => [error];
}
