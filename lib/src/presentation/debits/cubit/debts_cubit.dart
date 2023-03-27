import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enum/debt_type.dart';
import '../../../data/debt/models/debt_model.dart';
import '../../../domain/debt/entities/debt.dart';
import '../../../domain/debt/use_case/debt_use_case.dart';

part 'debts_event.dart';
part 'debts_state.dart';

@injectable
class DebtsBloc extends Bloc<DebtsEvent, DebtsState> {
  DebtsBloc({
    required this.addDebtUseCase,
    required this.getDebtUseCase,
    required this.getTransactionsUseCase,
    required this.addTransactionUseCase,
    required this.updateDebtUseCase,
  }) : super(DebtsInitial()) {
    on<AddTransactionToDebtEvent>(
        (event, emit) => _addTransactionToDebt(event, emit));
    on<ChangeDebtTypeEvent>((event, emit) => _changeType(event, emit));
    on<FetchDebtOrCreditFromIdEvent>(
        (event, emit) => _fetchDebtOrCreditFromId(event, emit));
    on<AddOrUpdateEvent>((event, emit) => addDebt(event, emit));
    on<SelectedDateEvent>(selectedDateEvent);
  }

  final AddDebtUseCase addDebtUseCase;
  final GetDebtUseCase getDebtUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;
  final AddTransactionUseCase addTransactionUseCase;
  final UpdateDebtUseCase updateDebtUseCase;

  DebtType currentDebtType = DebtType.debt;
  Debt? currentDebt;
  String? currentName;
  String? currentDescription;
  double? currentAmount;
  DateTime? currentDateTime;
  DateTime? currentDueDateTime;

  Future<void> _addTransactionToDebt(
    AddTransactionToDebtEvent event,
    Emitter<DebtsState> emit,
  ) async {
    await addTransactionUseCase(
      amount: event.amount,
      currentDateTime: DateTime.now(),
      parentId: event.debt.superId!,
    );
    emit(TransactionAddedState());
  }

  void _changeType(
    ChangeDebtTypeEvent event,
    Emitter<DebtsState> emit,
  ) {
    currentDebtType = event.debtType;
    emit(DebtsTabState(event.debtType));
  }

  Future<void> _fetchDebtOrCreditFromId(
    FetchDebtOrCreditFromIdEvent event,
    Emitter<DebtsState> emit,
  ) async {
    final int? debtId = int.tryParse(event.id ?? '');
    if (debtId == null) return emit(const DebtErrorState('Debt not found'));

    final Debt? debt = getDebtUseCase(debtId);
    if (debt != null) {
      currentAmount = debt.amount;
      currentName = debt.name;
      currentDescription = debt.description;
      currentDateTime = debt.dateTime;
      currentDueDateTime = debt.expiryDateTime;
      currentDebtType = debt.debtType;
      currentDebt = debt;
      emit(DebtsSuccessState(debt));
      Future.delayed(Duration.zero).then((value) =>
          add(SelectedDateEvent(currentDateTime!, currentDueDateTime!)));
    } else {
      emit(const DebtErrorState('Debt not found'));
    }
  }

  Future<void> addDebt(
    AddOrUpdateEvent event,
    Emitter<DebtsState> emit,
  ) async {
    final String? name = currentName?.trim();
    final double? amount = currentAmount;
    final String? description = currentDescription?.trim();
    final DateTime? dateTime = currentDateTime;
    final DateTime? dueDateTime = currentDueDateTime;
    final DebtType debtType = currentDebtType;

    if (amount == null) {
      return emit(const DebtErrorState('Enter amount'));
    }
    if (name == null) {
      return emit(const DebtErrorState('Debt name'));
    }

    if (dateTime == null) {
      return emit(const DebtErrorState('Select start date'));
    }

    if (dueDateTime == null) {
      return emit(const DebtErrorState('Select end date'));
    }
    if (event.isUpdate) {
      await addDebtUseCase(
        amount: amount,
        currentDateTime: dateTime,
        debtType: debtType,
        description: description ?? '',
        dueDateTime: dueDateTime,
        name: name,
      );
    } else {
      if (currentDebt != null) {
        currentDebt!
          ..amount = amount
          ..dateTime = dateTime
          ..debtType = debtType
          ..description = description ?? ''
          ..expiryDateTime = dueDateTime
          ..name = name;
        await updateDebtUseCase(currentDebt!);
      }
    }
    emit(DebtsAdded(isUpdate: event.isUpdate));
  }

  FutureOr<void> selectedDateEvent(
    SelectedDateEvent event,
    Emitter<DebtsState> emit,
  ) {
    currentDateTime = event.startDateTime;
    currentDueDateTime = event.endDateTime;
    emit(SelectedDateState(event.startDateTime, event.endDateTime));
  }
}
