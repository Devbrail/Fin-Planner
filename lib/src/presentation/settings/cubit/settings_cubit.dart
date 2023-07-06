import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import '../../../../main.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/category/use_case/category_use_case.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../../domain/expense/use_case/expense_use_case.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/settings/file_handler.dart';
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
  ) : super(DataInitial());

  final GetDefaultCategoriesUseCase defaultCategoriesUseCase;
  final GetExpensesUseCase expensesUseCase;
  final Box<dynamic> settings;
  final UpdateExpensesUseCase updateExpensesUseCase;

  void importDataFromJson() {
    _importFile();
  }

  void exportDataToJson() {
    emit(const DataLoadingState(false));
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    deviceInfo.androidInfo.then((androidInfo) {
      Permission.storage.request().then((statusManageExternalStorage) {
        if (statusManageExternalStorage.isGranted &&
            androidInfo.version.sdkInt > 29) {
          _exportFile();
        } else if (androidInfo.version.sdkInt < 30) {
          Permission.storage.request().isGranted.then((value) {
            if (value) {
              _exportFile();
            } else {
              emit(const DataError('Permission error'));
            }
          });
        }
      });
    });
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

  /* FutureOr<void> _checkDefaultCategory(
    CheckDefaultCategoryEvent event,
    Emitter<HomeState> emit,
  ) {
    final List<Expense> expenses = expensesUseCase();
    final bool showFixDialog =
        expenses.where((element) => element.categoryId == -1).isNotEmpty;
    if (showFixDialog) {
      emit(ShowFixDialogState());
    }
  } */
  void _exportFile() {
    final FileHandler fileHandler = getIt.get<FileHandler>();
    fileHandler.backupDataIntoFile().then((value) => emit(DataExportState()));
  }

  void shareFile() {
    final FileHandler fileHandler = getIt.get<FileHandler>();
    fileHandler.fetchXFileJSONToShare().then((value) => Share.shareXFiles(
          [value],
          subject: 'Share',
        ));
  }

  void _importFile() {
    final FileHandler fileHandler = getIt.get<FileHandler>();
    fileHandler.importDataFromFile().then((value) => emit(DataSuccessState()));
  }
}
