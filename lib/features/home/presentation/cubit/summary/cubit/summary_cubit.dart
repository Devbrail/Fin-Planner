import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/features/home/domain/use_case/combined_transaction_use_case.dart';

@injectable
class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit(this.combinedTransactionUseCase) : super(SummaryInitial());
  final CombinedTransactionUseCase combinedTransactionUseCase;

  void fetch() {
    //combinedTransactionUseCase().then((result) => print);
  }
}

abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

class SummaryInitial extends SummaryState {}
