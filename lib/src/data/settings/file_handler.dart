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
import '../accounts/data_sources/account_local_data_source.dart';
import '../accounts/model/account.dart';
import '../category/data_sources/category_local_data_source.dart';
import '../category/model/category.dart';
import '../expense/data_sources/expense_manager_local_data_source.dart';
import '../expense/model/expense.dart';
import 'data.dart';

@Singleton()
class FileHandler {
  Future<XFile> fetchXFileJSONToShare() async {
    final String jsonString = await _fetchExpensesAndEncode();
    return XFile.fromData(
      Uint8List.fromList(jsonString.codeUnits),
      name: 'paisa_backup_${DateTime.now().toIso8601String()}.json',
      mimeType: 'application/json',
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
    final expenseDataStore = getIt.get<LocalExpenseManagerDataSource>();
    final Iterable<Expense> expenses = expenseDataStore.exportData();

    final accountDataStore = getIt.get<LocalAccountManagerDataSource>();
    final Iterable<Account> accounts = accountDataStore.exportData();

    final categoryDataStore = getIt.get<LocalCategoryManagerDataSource>();
    final Iterable<Category> categories = categoryDataStore.exportData();

    final data = {
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'accounts': accounts.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => e.toJson()).toList(),
    };
    return json.encode(data);
  }

  List<List<String>> fetch() {
    final expenseDataStore = getIt.get<LocalExpenseManagerDataSource>();
    final Iterable<Expense> expenses = expenseDataStore.exportData();
    final accountDataStore = getIt.get<LocalAccountManagerDataSource>();
    final categoryDataStore = getIt.get<LocalCategoryManagerDataSource>();
    return csvDataList(expenses.toList(), accountDataStore, categoryDataStore);
  }

  List<List<String>> csvDataList(
    List<Expense> expenses,
    LocalAccountManagerDataSource accountDataSource,
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
            return expenseRow(
              index,
              expense: expense,
              account: account,
              category: category,
            );
          },
        ),
      ];

  List<String> expenseRow(
    int index, {
    required Expense expense,
    required Account account,
    required Category category,
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
      final accountBox = Hive.box<Account>(BoxType.accounts.name);
      final categoryBox = Hive.box<Category>(BoxType.category.name);
      final expenseBox = Hive.box<Expense>(BoxType.expense.name);
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
