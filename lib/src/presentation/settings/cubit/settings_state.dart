part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class DataInitial extends SettingsState {}

class DataSuccessState extends SettingsState {}

class DataLoadingState extends SettingsState {
  const DataLoadingState(this.isLoadingImport);

  final bool isLoadingImport;
}

class DataExportState extends SettingsState {}

class DataError extends SettingsState {
  const DataError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class ExpenseFixStarted extends SettingsState {}

class ExpenseFixDone extends SettingsState {}

class ExpenseFixError extends SettingsState {}
