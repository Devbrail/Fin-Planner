import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/category/data/model/category_model.dart';
import 'package:paisa/features/home/data/models/combined_transaction.dart';
import 'package:paisa/features/transaction/data/model/transaction_model.dart';

abstract class CombinedTransactionManager {
  Future<List<CombinedTransaction>> fetch();
}

@Singleton(as: CombinedTransactionManager)
class CombinedTransactionManagerImpl implements CombinedTransactionManager {
  CombinedTransactionManagerImpl(
    this.transactionModelBox,
    this.accountModelBox,
    this.categoryModelBox,
  );

  final Box<AccountModel> accountModelBox;
  final Box<CategoryModel> categoryModelBox;
  final Box<TransactionModel> transactionModelBox;

  @override
  Future<List<CombinedTransaction>> fetch() async {
    final List<TransactionModel> transactionModelList =
        transactionModelBox.values.toList();

    final List<AccountModel> accountModelList = accountModelBox.values.toList();

    final List<CategoryModel> categoryModelList =
        categoryModelBox.values.toList();
    final isolate = await compute(_runIsolate, [
      transactionModelList,
      accountModelList,
      categoryModelList,
    ]);

    return [];
  }

  void _runIsolate(List<dynamic> args) {
    final List<TransactionModel> transactionModelList = args[0];

    final List<AccountModel> accountModelList = args[1];

    final List<CategoryModel> categoryModelList = args[2];

    final Map<int, AccountModel> accountModelMap = Map.fromEntries(
      accountModelList.map((AccountModel accountModel) {
        return MapEntry(
          accountModel.superId!,
          accountModel,
        );
      }),
    );

    final Map<int, CategoryModel> categoryModelMap = Map.fromEntries(
      categoryModelList.map((CategoryModel categoryModel) {
        return MapEntry(
          categoryModel.superId!,
          categoryModel,
        );
      }),
    );

    final result = transactionModelList.map((transactionModel) {
      return CombinedTransaction(
        accountModel: accountModelMap[transactionModel.accountId],
        categoryModel: categoryModelMap[transactionModel.categoryId],
        currency: transactionModel.currency,
        description: transactionModel.description,
        name: transactionModel.name,
        superId: transactionModel.superId,
        time: transactionModel.time,
        type: transactionModel.type,
      );
    }).toList();
    print(result);
  }
}
