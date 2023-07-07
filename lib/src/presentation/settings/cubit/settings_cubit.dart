import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/settings/file_handler.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/category/use_case/category_use_case.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';
import '../../../domain/expense/use_case/update_expense_use_case.dart';

part 'settings_state.dart';

const expenseFixKey = "expense_fix_key";

@injectable
class SettingCubit extends Cubit<SettingsState> {
  SettingCubit(
    @Named('settings') this.settings,
    this.expensesUseCase,
    this.defaultCategoriesUseCase,
    this.updateExpensesUseCase,
    this.fileHandler,
  ) : super(DataInitial());

  final GetDefaultCategoriesUseCase defaultCategoriesUseCase;
  final GetExpensesUseCase expensesUseCase;
  final Box<dynamic> settings;
  final UpdateExpensesUseCase updateExpensesUseCase;
  final FileHandler fileHandler;

  void importDataFromJson() {
    _importFile();
  }

  void fixExpenses() async {
    if (settings.get(expenseFixKey, defaultValue: true)) {
      emit(ExpenseFixStarted());
      final List<Category> categories = defaultCategoriesUseCase();
      if (categories.isEmpty) {
        return emit(ExpenseFixError());
      }
      final List<Expense> expenses = expensesUseCase()
          .where((element) => element.categoryId == -1)
          .toList();

      for (var element in expenses) {
        element.categoryId = categories.first.superId!;
        await updateExpensesUseCase(element);
      }
      settings.put(expenseFixKey, false);
      emit(ExpenseFixDone());
    }
  }

  void shareFile() {
    fileHandler.exportDataIntoXFile().then((value) => Share.shareXFiles(
          [value],
          subject: 'Share',
        ));
  }

  void _importFile() {
    fileHandler.importDataFromFile().then((value) {
      value.fold(
        (l) => emit(DataError(l)),
        (r) => emit(DataSuccessState()),
      );
    });
  }
}
