import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/error/exceptions.dart';
import '../../../domain/settings/repository/import_export.dart';
import '../../../presentation/settings/cubit/settings_cubit.dart';
import '../../accounts/data_sources/local_account_data_manager.dart';
import '../../accounts/model/account_model.dart';
import '../../category/data_sources/category_local_data_source.dart';
import '../../category/model/category_model.dart';
import '../../expense/data_sources/local_expense_data_manager.dart';
import '../../expense/model/expense_model.dart';
import '../model/data.dart';

@Named('json_export')
@LazySingleton(as: Export)
class JSONExportImpl implements Export {
  JSONExportImpl(
    this.accountDataManager,
    this.categoryDataManager,
    this.expenseDataManager,
  );

  final AccountLocalDataManager accountDataManager;
  final CategoryLocalDataManager categoryDataManager;
  final ExpenseLocalDataManager expenseDataManager;

  @override
  Future<String> export() async {
    final File file = await getTempFile();
    final List<int> jsonBytes = await _fetchAllDataAndEncode();
    await file.writeAsBytes(jsonBytes);
    return file.path;
  }

  Future<File> getTempFile() async {
    final Directory tempDir = await getTemporaryDirectory();
    return await File('${tempDir.path}/paisa_backup.json').create();
  }

  Future<List<int>> _fetchAllDataAndEncode() async {
    final Iterable<ExpenseModel> expenses = expenseDataManager.export();
    final Iterable<AccountModel> accounts = accountDataManager.export();
    final Iterable<CategoryModel> categories = categoryDataManager.export();

    final Map<String, dynamic> data = {
      'version': 1,
      'expenses': expenses.toJson(),
      'accounts': accounts.toJson(),
      'categories': categories.toJson(),
    };
    return utf8.encode(jsonEncode(data));
  }
}

@Named('json_import')
@LazySingleton(as: Import)
class JSONImportImpl implements Import {
  JSONImportImpl(
    this.deviceInfo,
    this.accountDataManager,
    this.categoryDataManager,
    this.expenseDataManager,
  );

  final AccountLocalDataManager accountDataManager;
  final CategoryLocalDataManager categoryDataManager;
  final DeviceInfoPlugin deviceInfo;
  final ExpenseLocalDataManager expenseDataManager;

  @override
  Future<bool> import() async {
    try {
      final FilePickerResult? result = await _pickFile();
      if (result == null || result.files.isEmpty) {
        throw FileNotFoundException();
      }

      final jsonString = await _readJSONFromFile(result.files.first.path!);
      final Data data = Data.fromRawJson(jsonString);

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

      return settings.put(expenseFixKey, true).then((value) => true);
    } catch (err) {
      debugPrint(err.toString());
      throw ErrorFileException();
    }
  }

  Future<FilePickerResult?> _pickFile() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return FilePicker.platform.pickFiles(
        type: androidInfo.version.sdkInt < 29 ? FileType.any : FileType.custom,
        allowedExtensions: androidInfo.version.sdkInt < 29 ? null : ['json'],
        allowMultiple: false,
      );
    } else {
      return FilePicker.platform.pickFiles();
    }
  }

  Future<String> _readJSONFromFile(String path) async {
    final Uint8List bytes = await File(path).readAsBytes();
    return String.fromCharCodes(bytes);
  }
}
