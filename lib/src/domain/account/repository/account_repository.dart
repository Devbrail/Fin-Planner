import 'package:dartz/dartz.dart';
import 'package:paisa/src/core/error/failures.dart';

import '../../../core/enum/card_type.dart';
import '../../../data/accounts/model/account_model.dart';

abstract class AccountRepository {
  Future<Either<Failure, void>> add({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  });

  Future<Either<Failure, void>> update({
    required int key,
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  });

  Future<Either<Failure, void>> delete(int key);

  Either<Failure, AccountModel> find(int accountId);

  Either<Failure, Iterable<AccountModel>> accounts();

  Future<Either<Failure, int>> clear();
}
