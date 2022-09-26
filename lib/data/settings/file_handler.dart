import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_paisa/common/enum/box_types.dart';
import 'package:flutter_paisa/data/accounts/datasources/account_local_data_source.dart';
import 'package:flutter_paisa/data/accounts/model/account.dart';
import 'package:flutter_paisa/data/category/datasources/category_local_data_source.dart';
import 'package:flutter_paisa/data/category/model/category.dart';
import 'package:flutter_paisa/data/expense/datasources/expense_manager_local_data_source.dart';
import 'package:flutter_paisa/data/expense/model/expense.dart';
import 'package:flutter_paisa/data/settings/data.dart';
import 'package:flutter_paisa/di/service_locator.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class FileHandler {
  Future<String> _fetchExpensesAndEncode() async {
    final Iterable<Expense> expenses =
        await locator.get<ExpenseManagerLocalDataSource>().exportData();
    final Iterable<Account> accounts =
        await locator.get<AccountLocalDataSource>().exportData();
    final Iterable<Category> categories =
        await locator.get<CategoryLocalDataSource>().exportData();

    final data = {
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'accounts': accounts.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => e.toJson()).toList(),
    };
    return json.encode(data);
  }

  Future<void> createBackUpFile() async {
    await Permission.storage.request();
    final String data = await _fetchExpensesAndEncode();
    final directory = await getApplicationSupportDirectory();
    final path = "${directory.path}/paisa-expense-manager.json";
    final file = File(path);
    await file.writeAsString(data);
    await Share.shareFiles([path], subject: 'Export JSON');
  }

  Future<File?> _pickJSONFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<void> restoreBackUpFile() async {
    File? file = await _pickJSONFile();
    if (file != null) {
      final jsonString = await file.readAsString();
      final data = Data.fromRawJson(jsonString);
      final accountBox = Hive.box<Account>(BoxType.accounts.stringValue);
      final categoryBox = Hive.box<Category>(BoxType.category.stringValue);
      final expenseBox = Hive.box<Expense>(BoxType.expense.stringValue);
      await expenseBox.clear();
      await categoryBox.clear();
      await accountBox.clear();

      await expenseBox.addAll(data.expenses);
      await categoryBox.addAll(data.categories);
      await accountBox.addAll(data.accounts);
    }
  }
}
