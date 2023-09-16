import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit() : super(SummaryInitial());
}

abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

class SummaryInitial extends SummaryState {}
