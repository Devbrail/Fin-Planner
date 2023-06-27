part of 'data_cubit.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataSuccessState extends DataState {}

class DataLoadingState extends DataState {
  const DataLoadingState(this.isLoadingImport);

  final bool isLoadingImport;
}

class DataExportState extends DataState {}

class DataError extends DataState {
  const DataError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
