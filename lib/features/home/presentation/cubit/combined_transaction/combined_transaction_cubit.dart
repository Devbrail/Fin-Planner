import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/account/domain/use_case/account_use_case.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/category/domain/use_case/category_use_case.dart';
import 'package:paisa/features/home/domain/entity/combined_request.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/use_case/transaction_use_case.dart';

@injectable
class CombinedTransactionCubit extends Cubit<CombinedTransactionState> {
  CombinedTransactionCubit(
    this.getTransactionsUseCase,
    this.getAccountsUseCase,
    this.getCategoriesUseCase,
    this.getTransactionsByCategoryIdUseCase,
    this.getCategoryUseCase,
  ) : super(CombinedTransactionInitial()) {
    fetchTransactions();
  }

  final GetTransactionsUseCase getTransactionsUseCase;
  final GetAccountsUseCase getAccountsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetTransactionsByCategoryIdUseCase getTransactionsByCategoryIdUseCase;
  final GetCategoryUseCase getCategoryUseCase;

  void fetchTransactions() {
    final List<AccountEntity> accounts = getAccountsUseCase();
    final List<CategoryEntity> categories = getCategoriesUseCase();
    final List<TransactionEntity> transactions = getTransactionsUseCase();
    final CombineRequest request =
        CombineRequest(accounts, categories, transactions);
    compute(combineList, request).then(
        (List<CombinedTransactionEntity> result) =>
            emit(CombinedResultState(result)));
  }

  void fetchTransactionsByCategoryId(int categoryId) {
    final List<TransactionEntity> transactions =
        getTransactionsByCategoryIdUseCase(
      params: GetTransactionsByCategoryIdParams(categoryId),
    );
    final List<AccountEntity> accounts = getAccountsUseCase();
    final List<CategoryEntity> categories = [
      getCategoryUseCase(params: GetCategoryParams(categoryId))!
    ];
    final CombineRequest request =
        CombineRequest(accounts, categories, transactions);
    compute(combineList, request).then(
        (List<CombinedTransactionEntity> result) =>
            emit(ResultByCategoryIdState(result)));
  }
}

List<CombinedTransactionEntity> combineList(CombineRequest request) {
  final Map<int, AccountEntity> accountMap = Map.fromEntries(
    request.accounts.map((AccountEntity account) {
      return MapEntry(
        account.superId!,
        account,
      );
    }),
  );

  final Map<int, CategoryEntity> categoryMap = Map.fromEntries(
    request.categories.map((CategoryEntity category) {
      return MapEntry(
        category.superId!,
        category,
      );
    }),
  );

  final List<CombinedTransactionEntity> result =
      request.transactions.map((TransactionEntity transaction) {
    return CombinedTransactionEntity(
      account: accountMap[transaction.accountId],
      category: categoryMap[transaction.categoryId],
      currency: transaction.currency,
      description: transaction.description,
      name: transaction.name,
      superId: transaction.superId,
      time: transaction.time,
      type: transaction.type,
    );
  }).toList();
  return result;
}

abstract class CombinedTransactionState extends Equatable {
  const CombinedTransactionState();

  @override
  List<Object> get props => [];
}

class CombinedTransactionInitial extends CombinedTransactionState {}

class CombinedResultState extends CombinedTransactionState {
  const CombinedResultState(this.result);

  final List<CombinedTransactionEntity> result;
}

class ResultByCategoryIdState extends CombinedTransactionState {
  const ResultByCategoryIdState(this.result);

  final List<CombinedTransactionEntity> result;
}
