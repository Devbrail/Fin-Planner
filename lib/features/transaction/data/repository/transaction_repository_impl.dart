import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/error/failures.dart';
import 'package:paisa/features/transaction/data/data_sources/local/transaction_data_manager.dart';
import 'package:paisa/features/transaction/data/model/transaction_model.dart';
import 'package:paisa/features/transaction/data/model/search_query.dart';
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart';

@Singleton(as: TransactionRepository)
class ExpenseRepositoryImpl extends TransactionRepository {
  ExpenseRepositoryImpl({
    required this.dataSource,
  });

  final LocalTransactionManager dataSource;

  @override
  Future<Either<Failure, bool>> addExpense(
    String? name,
    double? amount,
    DateTime? time,
    int? category,
    int? account,
    TransactionType? transactionType,
    String? description,
  ) async {
    try {
      final int result = await dataSource.add(
        TransactionModel(
          name: name,
          currency: amount,
          time: time,
          categoryId: category,
          accountId: account,
          type: transactionType,
          description: description,
        ),
      );
      if (result != -1) {
        return right(true);
      } else {
        return right(false);
      }
    } catch (err) {
      debugPrint(err.toString());
      return left(FailedToAddTransactionFailure());
    }
  }

  @override
  Future<void> clearAll() => dataSource.clear();

  @override
  Future<void> clearExpense(int expenseId) async {
    return dataSource.deleteById(expenseId);
  }

  @override
  Future<void> deleteExpensesByAccountId(int accountId) {
    return dataSource.deleteByAccountId(accountId);
  }

  @override
  Future<void> deleteExpensesByCategoryId(int categoryId) {
    return dataSource.deleteByCategoryId(categoryId);
  }

  @override
  List<TransactionModel> expenses() => dataSource.expenses();

  @override
  TransactionModel? fetchExpenseFromId(int expenseId) {
    return dataSource.findById(expenseId);
  }

  @override
  List<TransactionModel> fetchExpensesFromAccountId(int accountId) {
    return dataSource.findByAccountId(accountId);
  }

  @override
  List<TransactionModel> fetchExpensesFromCategoryId(int accountId) {
    return dataSource.findByCategoryId(accountId);
  }

  @override
  List<TransactionModel> filterExpenses(
    String query,
    List<int> accounts,
    List<int> categories,
  ) {
    return dataSource.filterExpenses(SearchQuery(
      query: query,
      accounts: accounts,
      categories: categories,
    ));
  }

  @override
  Future<void> updateExpense(
    int key,
    String? name,
    double? currency,
    DateTime? time,
    int? categoryId,
    int? accountId,
    TransactionType? transactionType,
    String? description,
  ) {
    return dataSource.update(
      TransactionModel(
        name: name,
        currency: currency,
        time: time,
        categoryId: categoryId,
        accountId: accountId,
        type: transactionType,
        description: description,
        superId: key,
      ),
    );
  }
}
