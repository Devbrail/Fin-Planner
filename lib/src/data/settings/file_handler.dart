import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../main.dart';
import '../../core/enum/box_types.dart';
import '../accounts/data_sources/local_account_data_manager.dart';
import '../accounts/model/account_model.dart';
import '../category/data_sources/category_local_data_source.dart';
import '../category/model/category_model.dart';
import '../expense/data_sources/local_expense_data_manager.dart';
import '../expense/model/expense_model.dart';
import 'data.dart';

@Singleton()
class FileHandler {
  Future<XFile> fetchXFileJSONToShare() async {
    final String jsonString = await _fetchExpensesAndEncode();
    return XFile.fromData(
      Uint8List.fromList(jsonString.codeUnits),
      name: 'paisa_backup_${DateTime.now().toIso8601String()}.json',
      mimeType: 'application/json',
      lastModified: DateTime.now(),
    );
  }

  Future<XFile> fetchXFileCSVToShare() async {
    final String jsonString = await _fetchExpensesAndEncode();
    return XFile.fromData(
      Uint8List.fromList(jsonString.codeUnits),
      name: 'paisa_backup_${DateTime.now().toIso8601String()}.json',
      mimeType: 'application/json',
    );
  }

  Future<String> _fetchExpensesAndEncode() async {
    final expenseDataStore = getIt.get<LocalExpenseDataManager>();
    final Iterable<ExpenseModel> expenses = expenseDataStore.exportData();

    final accountDataStore = getIt.get<LocalAccountDataManager>();
    final Iterable<AccountModel> accounts = accountDataStore.exportData();

    final categoryDataStore = getIt.get<LocalCategoryManagerDataSource>();
    final Iterable<CategoryModel> categories = categoryDataStore.exportData();

    final data = {
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'accounts': accounts.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => e.toJson()).toList(),
    };
    return json.encode(data);
  }

  List<List<String>> fetch() {
    final expenseDataStore = getIt.get<LocalExpenseDataManager>();
    final Iterable<ExpenseModel> expenses = expenseDataStore.exportData();
    final accountDataStore = getIt.get<LocalAccountDataManager>();
    final categoryDataStore = getIt.get<LocalCategoryManagerDataSource>();
    return csvDataList(expenses.toList(), accountDataStore, categoryDataStore);
  }

  List<List<String>> csvDataList(
    List<ExpenseModel> expenses,
    LocalAccountDataManager accountDataSource,
    LocalCategoryManagerDataSource categoryDataSource,
  ) =>
      [
        [
          'No',
          'Expense Name',
          'Amount',
          'Date',
          'Category Name',
          'Category Description',
          'Account Name',
          'Bank Name',
          'Account Type',
        ],
        ...List.generate(
          expenses.length,
          (index) {
            final expense = expenses[index];
            final account =
                accountDataSource.fetchAccountFromId(expense.accountId);
            final category =
                categoryDataSource.fetchCategoryFromId(expense.categoryId);
            if (account != null && category != null) {
              return expenseRow(
                index,
                expense: expense,
                account: account,
                category: category,
              );
            } else {
              return [];
            }
          },
        ),
      ];

  List<String> expenseRow(
    int index, {
    required ExpenseModel expense,
    required AccountModel account,
    required CategoryModel category,
  }) =>
      [
        '$index',
        expense.name,
        '${expense.currency}',
        expense.time.toIso8601String(),
        category.name,
        category.description ?? '',
        account.name,
        account.bankName,
        account.cardType!.name,
      ];

  Future<void> restoreBackUpFile({
    FileSystemEntity? fileSystemEntity,
  }) async {
    final result = await _checkPermission();
    if (!result) {
      return;
    }

    File? file;
    if (fileSystemEntity != null) {
      file = File(fileSystemEntity.path);
    } else {
      file = await _pickJSONFile();
    }
    if (file != null) {
      final jsonString = await file.readAsString();
      final data = Data.fromRawJson(jsonString);
      final accountBox = Hive.box<AccountModel>(BoxType.accounts.name);
      final categoryBox = Hive.box<CategoryModel>(BoxType.category.name);
      final expenseBox = Hive.box<ExpenseModel>(BoxType.expense.name);
      await expenseBox.clear();
      await categoryBox.clear();
      await accountBox.clear();

      await expenseBox.addAll(data.expenses);
      await categoryBox.addAll(data.categories);
      await accountBox.addAll(data.accounts);
    }
  }

  Future<File?> _pickJSONFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<bool> _checkPermission() async {
    final result = await Permission.manageExternalStorage.status;
    if (result.isGranted) {
      return true;
    } else if (result.isDenied) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
    }
    return false;
  }
}
