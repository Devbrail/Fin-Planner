import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/core/error/failures.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/category/domain/use_case/category_use_case.dart';
import 'package:paisa/features/settings/domain/use_case/setting_use_case.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/transaction/domain/use_case/transaction_use_case.dart';
import 'package:share_plus/share_plus.dart';

import 'package:paisa/core/common.dart';

part 'settings_state.dart';

const String expenseFixKey = "expense_fix_key";

@injectable
class SettingCubit extends Cubit<SettingsState> {
  SettingCubit(
    this.transactionsUseCase,
    this.getDefaultCategoriesUseCase,
    this.updateExpensesUseCase,
    this.jsonFileImportUseCase,
    this.jsonFileExportUseCase,
    this.settingsUseCase,
    this.csvFileExportUseCase,
  ) : super(SettingsInitial());

  final CSVFileExportUseCase csvFileExportUseCase;
  final GetDefaultCategoriesUseCase getDefaultCategoriesUseCase;
  final JSONFileExportUseCase jsonFileExportUseCase;
  final JSONFileImportUseCase jsonFileImportUseCase;
  final SettingsUseCase settingsUseCase;
  final GetTransactionsUseCase transactionsUseCase;
  final UpdateTransactionUseCase updateExpensesUseCase;

  void fixExpenses() async {
    if (settingsUseCase.get(expenseFixKey, defaultValue: true)) {
      emit(FixExpenseLoading());
      final List<CategoryEntity> categories = getDefaultCategoriesUseCase();
      if (categories.isEmpty) {
        return emit(FixExpenseError());
      }
      final List<TransactionEntity> transactions = transactionsUseCase()
          .where((TransactionEntity element) => element.categoryId == -1)
          .toList();

      for (final TransactionEntity element in transactions) {
        await updateExpensesUseCase(
            params: UpdateTransactionParams(
          element.superId!,
          accountId: element.accountId,
          categoryId: categories.first.superId!,
          currency: element.currency,
          description: element.description,
          name: element.name,
          time: element.time,
          type: element.type,
        ));
      }
      await settingsUseCase.put(expenseFixKey, false);
      emit(FixExpenseDone());
    }
  }

  void shareFile() {
    jsonFileExportUseCase().then((Either<Failure, String> fileExport) => fileExport.fold(
          (Failure failure) => emit(ImportFileError(mapFailureToMessage(failure))),
          (String path) => Share.shareXFiles(
            [XFile(path)],
            subject: 'Share',
          ),
        ));
  }

  void shareCSVFile() {
    csvFileExportUseCase().then((Either<Failure, String> fileExport) => fileExport.fold(
          (Failure failure) => emit(ImportFileError(mapFailureToMessage(failure))),
          (String path) => Share.shareXFiles(
            [XFile(path)],
            subject: 'Share',
          ),
        ));
  }

  void importDataFromJson() {
    emit(ImportFileLoading());
    jsonFileImportUseCase().then((Either<Failure, bool> fileImport) => fileImport.fold(
          (Failure failure) => emit(ImportFileError(mapFailureToMessage(failure))),
          (bool r) => emit(ImportFileSuccessState()),
        ));
  }

  int? get defaultAccountId => settingsUseCase.get(defaultAccountIdKey);

  dynamic setDefaultAccountId(int accountId) =>
      settingsUseCase.put(defaultAccountIdKey, accountId);
}
