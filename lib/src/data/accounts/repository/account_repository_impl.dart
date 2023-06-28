import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enum/card_type.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../domain/account/repository/account_repository.dart';
import '../data_sources/account_local_data_source.dart';
import '../model/account_model.dart';

@Singleton(as: AccountRepository)
class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({required this.dataSource});

  final AccountLocalDataSource dataSource;

  @override
  Future<Either<Failure, void>> add({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  }) async {
    try {
      return Right(
        dataSource.add(
          AccountModel(
            name: holderName,
            bankName: bankName,
            number: number,
            cardType: cardType,
            amount: amount,
            color: color,
          ),
        ),
      );
    } on NotableToAddException {
      return Left(NotableToAddFailure());
    }
  }

  @override
  Future<Either<Failure, int>> clear() async {
    try {
      final int result = await dataSource.clear();
      return Right(result);
    } on NotableToClearException {
      return Left(NotableToClearFailure());
    }
  }

  @override
  Either<Failure, AccountModel> find(int accountId) {
    try {
      final AccountModel? accountModel = dataSource.find(accountId);
      if (accountModel == null) {
        return Left(NotableToClearFailure());
      } else {
        return Right(accountModel);
      }
    } on NotableToClearException {
      return Left(NotableToClearFailure());
    }
  }

  @override
  Either<Failure, Iterable<AccountModel>> accounts() {
    try {
      final accounts = dataSource.all();
      if (accounts.isNotEmpty) {
        return Right(accounts);
      } else {
        return Left(NoItemsFailure());
      }
    } on NoItemsException {
      return Left(NoItemsFailure());
    }
  }

  @override
  Future<Either<Failure, void>> delete(int key) async {
    try {
      return Right(dataSource.delete(key));
    } on NotableToDeleteException {
      return Left(NotableToClearFailure());
    }
  }

  @override
  Future<Either<Failure, void>> update(
      {required int key,
      required String bankName,
      required String holderName,
      required String number,
      required CardType cardType,
      required double amount,
      required int color}) async {
    try {
      return Right(dataSource.update(
        AccountModel(
          name: holderName,
          bankName: bankName,
          number: number,
          cardType: cardType,
          amount: amount,
          superId: key,
          color: color,
        ),
      ));
    } on NotableToDeleteException {
      return Left(NotableToAddFailure());
    }
  }
}
