import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FilterDateCubit extends Cubit<FilterDateState> {
  FilterDateCubit() : super(FilterDateInitial());

  void filterDate(DateTimeRange dateTimeRange) {
    emit(FilterDateRangeState(dateTimeRange));
  }
}

abstract class FilterDateState extends Equatable {
  const FilterDateState();

  @override
  List<Object> get props => [];
}

class FilterDateInitial extends FilterDateState {}

class FilterDateRangeState extends FilterDateState {
  final DateTimeRange dateTimeRange;

  const FilterDateRangeState(this.dateTimeRange);

  @override
  List<Object> get props => [dateTimeRange];
}
