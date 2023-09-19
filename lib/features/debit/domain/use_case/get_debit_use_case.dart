import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/debit/domain/entities/debit.dart';
import 'package:paisa/features/debit/domain/repository/debit_repository.dart';

@singleton
class GetDebitUseCase implements UseCase<Debit?, GetDebitParams> {
  GetDebitUseCase({required this.debtRepository});

  final DebitRepository debtRepository;

  @override
  Debit? call(GetDebitParams params) {
    return debtRepository.fetchDebtOrCreditFromId(params.debitId)?.toEntity();
  }
}

class GetDebitParams extends Equatable {
  const GetDebitParams(this.debitId);

  final int debitId;

  @override
  List<Object?> get props => [debitId];
}
