part of 'data_cubit.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataSuccessState extends DataState {}

class DataLoadingState extends DataState {
  final bool isLoadingImport;

  const DataLoadingState(this.isLoadingImport);
}

class DataExportState extends DataState {}

class DataError extends DataState {
  final String error;

  const DataError(this.error);

  @override
  List<Object> get props => [error];
}
