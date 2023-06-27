import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/core/error/exceptions.dart';
import 'package:paisa/src/core/error/failures.dart';

import '../../../core/enum/card_type.dart';
import '../../../domain/account/repository/account_repository.dart';
import '../data_sources/account_local_data_source.dart';
import '../model/account_model.dart';

@Singleton(as: AccountRepository)
class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({required this.dataSource});

  final AccountLocalDataSource dataSource;

  @override
  Future<void> addAccount({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  }) {
    return dataSource.addAccount(AccountModel(
      name: holderName,
      bankName: bankName,
      number: number,
      cardType: cardType,
      amount: amount,
      color: color,
    ));
  }

  @override
  Future<void> clearAll() => dataSource.clearAll();

  @override
  Future<void> deleteAccount(int key) => dataSource.deleteAccount(key);

  @override
  AccountModel? fetchAccountFromId(int accountId) =>
      dataSource.fetchAccountFromId(accountId);

  @override
  Either<Failure, Iterable<AccountModel>> accounts() {
    try {
      final accounts = dataSource.accounts();
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
  Future<void> updateAccount({
    required int key,
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
  }) {
    return dataSource.updateAccount(
      AccountModel(
        name: holderName,
        bankName: bankName,
        number: number,
        cardType: cardType,
        amount: amount,
        superId: key,
        color: color,
      ),
    );
  }
}
