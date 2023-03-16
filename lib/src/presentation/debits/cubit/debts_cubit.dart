import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enum/box_types.dart';
import '../../../core/enum/debt_type.dart';
import '../../../data/debt/models/debt_model.dart';
import '../../../data/debt/models/transactions_model.dart';
import '../../../domain/debt/use_case/debt_use_case.dart';

part 'debts_event.dart';
part 'debts_state.dart';

@injectable
class DebtsBloc extends Bloc<DebtsEvent, DebtsState> {
  DebtsBloc({
    required this.useCase,
  }) : super(DebtsInitial()) {
    on<AddTransactionToDebtEvent>(
        (event, emit) => _addTransactionToDebt(event, emit));
    on<ChangeDebtTypeEvent>((event, emit) => _changeType(event, emit));
    on<FetchDebtOrCreditFromIdEvent>(
        (event, emit) => _fetchDebtOrCreditFromId(event, emit));
    on<AddOrUpdateEvent>((event, emit) => addDebt(event, emit));
  }
  late final transactionBox =
      Hive.box<TransactionsModel>(BoxType.transactions.name);

  final DebtUseCase useCase;
  late DebtType currentDebtType = DebtType.debt;
  DebtModel? currentDebt;
  String? currentName;
  String? currentDescription;
  double? currentAmount;
  DateTime? currentDateTime;
  DateTime? currentDueDateTime;

  Future<void> _addTransactionToDebt(
    AddTransactionToDebtEvent event,
    Emitter<DebtsState> emit,
  ) async {
    final transaction = TransactionsModel(
      amount: event.amount,
      now: DateTime.now(),
      parentId: event.debt.superId!,
    );
    final int id = await transactionBox.add(transaction);
    transaction.superId = id;
    await transaction.save();
  }

  void _changeType(
    ChangeDebtTypeEvent event,
    Emitter<DebtsState> emit,
  ) =>
      emit(DebtsTabState(event.debtType));

  void _fetchDebtOrCreditFromId(
    FetchDebtOrCreditFromIdEvent event,
    Emitter<DebtsState> emit,
  ) {
    final int? debtId = int.tryParse(event.id ?? '');
    if (debtId == null) return;
    useCase.fetchDebtOrCreditFromId(debtId).then((DebtModel? debt) {
      if (debt != null) {
        currentAmount = debt.amount;
        currentName = debt.name;
        currentDescription = debt.description;
        currentDateTime = debt.dateTime;
        currentDueDateTime = debt.expiryDateTime;
        currentDebtType = debt.debtType;
        currentDebt = debt;
        emit(DebtsSuccessState(debt));
      } else {
        emit(const DebtErrorState('Debt not found'));
      }
    });
  }

  Future<void> addDebt(
    AddOrUpdateEvent event,
    Emitter<DebtsState> emit,
  ) async {
    final String? name = currentName;
    final double? amount = currentAmount;
    final String? description = currentDescription;
    final DateTime? dateTime = currentDateTime;
    final DateTime? dueDateTime = currentDueDateTime;
    final DebtType debtType = currentDebtType;

    if (name == null) {
      return emit(const DebtErrorState('Debt name'));
    }

    if (description == null) {
      return emit(const DebtErrorState('Description name'));
    }
    if (amount == null) {
      return emit(const DebtErrorState('Description name'));
    }
    if (dateTime == null) {
      return emit(const DebtErrorState('Description name'));
    }

    if (dueDateTime == null) {
      return emit(const DebtErrorState('Description name'));
    }
    if (event.isUpdate) {
      currentDebt!
        ..name = name
        ..amount = amount
        ..dateTime = dateTime
        ..expiryDateTime = dueDateTime
        ..description = description
        ..debtType = debtType;
      currentDebt!.save();
    } else {
      await useCase(
        description: description,
        name: name,
        amount: amount,
        currentDateTime: dateTime,
        dueDateTime: dueDateTime,
        debtType: debtType,
      );
    }
    emit(DebtsAdded(isUpdate: event.isUpdate));
  }
}
