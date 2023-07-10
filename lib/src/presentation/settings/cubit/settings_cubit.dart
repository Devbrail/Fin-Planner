import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/core/common.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/error/failures.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/category/use_case/category_use_case.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';
import '../../../domain/expense/use_case/update_expense_use_case.dart';
import '../../../domain/settings/use_case/setting_use_case.dart';

part 'settings_state.dart';

const expenseFixKey = "expense_fix_key";

@injectable
class SettingCubit extends Cubit<SettingsState> {
  SettingCubit(
    this.expensesUseCase,
    this.defaultCategoriesUseCase,
    this.updateExpensesUseCase,
    this.fileImportUseCase,
    this.fileExportUseCase,
    this.settingsUseCase,
  ) : super(SettingsInitial());

  final GetDefaultCategoriesUseCase defaultCategoriesUseCase;
  final GetExpensesUseCase expensesUseCase;

  final UpdateExpensesUseCase updateExpensesUseCase;
  final FileImportUseCase fileImportUseCase;
  final FileExportUseCase fileExportUseCase;
  final SettingsUseCase settingsUseCase;

  void fixExpenses() async {
    if (settingsUseCase.get(expenseFixKey, defaultValue: true)) {
      emit(FixExpenseLoading());
      final List<Category> categories = defaultCategoriesUseCase();
      if (categories.isEmpty) {
        return emit(FixExpenseError());
      }
      final List<Expense> expenses = expensesUseCase()
          .where((element) => element.categoryId == -1)
          .toList();

      for (var element in expenses) {
        element.categoryId = categories.first.superId!;
        await updateExpensesUseCase(element);
      }
      await settingsUseCase.put(expenseFixKey, false);
      emit(FixExpenseDone());
    }
  }

  void shareFile() {
    fileExportUseCase().then((fileExport) => fileExport.fold(
          (failure) => emit(ImportFileError(_mapFailureToMessage(failure))),
          (path) => Share.shareXFiles(
            [XFile(path)],
            subject: 'Share',
          ),
        ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case FileNotFoundFailure:
        return 'File not found';
      case ErrorFileExportFailure:
        return 'Error file export';
      default:
        return 'Unexpected error';
    }
  }

  void importDataFromJson() {
    emit(ImportFileLoading());
    fileImportUseCase().then((fileImport) => fileImport.fold(
          (failure) => emit(ImportFileError(_mapFailureToMessage(failure))),
          (r) => emit(ImportFileSuccessState()),
        ));
  }

  int? get defaultAccountId => settingsUseCase.get(defaultAccountIdKey);

  dynamic setDefaultAccountId(int accountId) =>
      settingsUseCase.put(defaultAccountIdKey, accountId);
}
