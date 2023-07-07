import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/routes.dart';
import '../../core/common.dart';
import '../../presentation/settings/cubit/settings_cubit.dart';
import '../accounts/data_sources/local_account_data_manager.dart';
import '../accounts/model/account_model.dart';
import '../category/data_sources/category_local_data_source.dart';
import '../category/model/category_model.dart';
import '../expense/data_sources/local_expense_data_manager.dart';
import '../expense/model/expense_model.dart';
import 'data.dart';

@Singleton()
class FileHandler {
  FileHandler(
    this.deviceInfo,
    this.accountDataManager,
    this.categoryDataManager,
    this.expenseDataManager,
  );

  final DeviceInfoPlugin deviceInfo;
  final AccountLocalDataManager accountDataManager;
  final CategoryLocalDataManager categoryDataManager;
  final ExpenseLocalDataManager expenseDataManager;

  Future<Either<String, bool>> importDataFromFile() async {
    try {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: androidInfo.version.sdkInt < 29 ? FileType.any : FileType.custom,
        allowedExtensions: androidInfo.version.sdkInt < 29 ? null : ['json'],
        allowMultiple: false,
      );
      if (result == null || result.files.isEmpty) {
        return left('No file is selected');
      }
      final file = File(result.files.first.path!);
      await readJSONDataFromFile(result.files.first.path!);
      final jsonString = await file.readAsString(encoding: utf8);
      final data = Data.fromRawJson(jsonString);

      await expenseDataManager.clear();
      await categoryDataManager.clear();
      await accountDataManager.clear();

      for (var element in data.accounts) {
        await accountDataManager.update(element);
      }

      for (var element in data.categories) {
        await categoryDataManager.update(element);
      }

      for (var element in data.expenses) {
        await expenseDataManager.update(element);
      }
      await settings.put(expenseFixKey, true);
      return right(true);
    } catch (err) {
      return left('Error reading file');
    }
  }

  Future<String> readJSONDataFromFile(String path) {
    return File(path).readAsString(encoding: utf8);
  }

  Future<XFile> exportDataIntoXFile() async {
    final String jsonString = await _fetchAllDataAndEncode();
    return XFile.fromData(
      Uint8List.fromList(jsonString.codeUnits),
      name: 'paisa_backup_${DateTime.now().toIso8601String()}.json',
      mimeType: 'application/json',
      lastModified: DateTime.now(),
    );
  }

  Future<String> _fetchAllDataAndEncode() async {
    final Iterable<ExpenseModel> expenses = expenseDataManager.export();
    final Iterable<AccountModel> accounts = accountDataManager.export();
    final Iterable<CategoryModel> categories = categoryDataManager.export();

    final data = {
      'expenses': expenses.toJson(),
      'accounts': accounts.toJson(),
      'categories': categories.toJson(),
    };
    return json.encode(data);
  }
}
