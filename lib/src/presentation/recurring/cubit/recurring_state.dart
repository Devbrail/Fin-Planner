part of 'recurring_cubit.dart';

abstract class RecurringState extends Equatable {
  const RecurringState();

  @override
  List<Object> get props => [];
}

class RecurringInitial extends RecurringState {}

class RecurringEventAddedState extends RecurringState {}

class RecurringErrorState extends RecurringState {
  final String error;

  const RecurringErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class RecurringTypeState extends RecurringState {
  final RecurringType recurringType;

  const RecurringTypeState(this.recurringType);

  @override
  List<Object> get props => [recurringType];
}

class TransactionTypeState extends RecurringState {
  final TransactionType transactionType;

  const TransactionTypeState(this.transactionType);

  @override
  List<Object> get props => [transactionType];
}
