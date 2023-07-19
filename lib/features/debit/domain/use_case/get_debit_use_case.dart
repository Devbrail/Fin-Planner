import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/features/debit/domain/entities/debit.dart';
import 'package:paisa/features/debit/domain/repository/debit_repository.dart';

@singleton
class GetDebtUseCase {
  GetDebtUseCase({required this.debtRepository});

  final DebtRepository debtRepository;

  Debit? call(int debtId) =>
      debtRepository.fetchDebtOrCreditFromId(debtId)?.toEntity();
}
