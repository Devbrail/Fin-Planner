import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/domain/account/entities/account.dart';
import 'package:paisa/src/domain/account/use_case/account_use_case.dart';
import 'package:paisa/src/domain/category/entities/category.dart';
import 'package:paisa/src/domain/category/use_case/category_use_case.dart';
import 'package:paisa/src/domain/expense/entities/enhanced_expense.dart';
import 'package:paisa/src/domain/expense/entities/expense.dart';
import 'package:paisa/src/domain/expense/use_case/get_expenses_use_case.dart';

part 'summary_state.dart';

@injectable
class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit(
    this.expensesUseCase,
    this.accountsUseCase,
    this.categoriesUseCase,
  ) : super(SummaryInitial());

  final GetExpensesUseCase expensesUseCase;
  final GetAccountsUseCase accountsUseCase;
  final GetCategoriesUseCase categoriesUseCase;

  void fetchExpenses() {
    final Map<int, Category> categories = categoriesUseCase.map();
    final Map<int, Account> accounts = accountsUseCase.map();

    final List<Expense> expenses = expensesUseCase();

    final List<EnhancedExpense> newExpenses = expenses
        .where((element) => element.accountId != -1 && element.categoryId != -1)
        .where((element) =>
            accounts[element.accountId] != null &&
            categories[element.categoryId] != null)
        .map(
      (e) {
        return EnhancedExpense(
          account: accounts[e.accountId]!,
          category: categories[e.categoryId]!,
          currency: e.currency,
          name: e.name,
          id: e.superId!,
          time: e.time,
          type: e.type!,
        );
      },
    ).toList();
    emit(SuccessState(newExpenses));
  }
}
