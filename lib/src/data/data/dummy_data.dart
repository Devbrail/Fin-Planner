import 'dart:math';

import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../core/enum/card_type.dart';
import '../../core/enum/transaction_type.dart';
import '../../domain/account/repository/account_repository.dart';
import '../../domain/category/repository/category_repository.dart';
import '../../domain/expense/repository/expense_repository.dart';

// Generate dummy data
Future<void> addDummyData() async {
  final AccountRepository accRepo = getIt.get();
  final CategoryRepository catRepo = getIt.get();
  final ExpenseRepository expRepo = getIt.get();
  final ints = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  for (var index in ints) {
    await accRepo.addAccount(
      bankName: 'Bank Name $index',
      holderName: 'Holder Name $index',
      number: '$index',
      cardType: CardType.bank,
      amount: 0,
      color: Colors.brown.shade200.value,
    );
    await catRepo.addCategory(
      name: 'Category Name $index',
      icon: Icons.abc.codePoint,
      color: Colors.amber.value,
    );
    for (var i = 0; i < 20; i++) {
      await expRepo.addExpense(
        'Name $index',
        Random().nextDouble() * 100000,
        DateTime.now().add(Duration(days: Random().nextInt(100))),
        index,
        index,
        Random().nextBool() ? TransactionType.expense : TransactionType.income,
        'description',
        null,
        null,
        0,
      );
    }
  }
}
