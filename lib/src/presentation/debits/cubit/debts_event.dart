part of 'debts_cubit.dart';

@immutable
abstract class DebtsEvent extends Equatable {
  const DebtsEvent();

  @override
  List<Object?> get props => [];
}

class AddTransactionToDebtEvent extends DebtsEvent {
  final DebtModel debt;
  final double amount;

  const AddTransactionToDebtEvent(this.debt, this.amount);

  @override
  List<Object?> get props => [debt, amount];
}

class FetchDebtOrCreditFromIdEvent extends DebtsEvent {
  final String? id;

  const FetchDebtOrCreditFromIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddOrUpdateEvent extends DebtsEvent {
  final bool isUpdate;

  const AddOrUpdateEvent(this.isUpdate);

  @override
  List<Object?> get props => [isUpdate];
}

class ChangeDebtTypeEvent extends DebtsEvent {
  final DebtType debtType;

  const ChangeDebtTypeEvent(this.debtType);

  @override
  List<Object?> get props => [debtType];
}

class SelectedDateEvent extends DebtsEvent {
  final DateTime startDateTime;
  final DateTime endDateTime;

  const SelectedDateEvent(this.startDateTime, this.endDateTime);

  @override
  List<Object> get props => [startDateTime, endDateTime];
}

class DeleteDebtEvent extends DebtsEvent {
  final int id;

  const DeleteDebtEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteTransactionEvent extends DebtsEvent {
  final int id;

  const DeleteTransactionEvent(this.id);

  @override
  List<Object?> get props => [id];
}
