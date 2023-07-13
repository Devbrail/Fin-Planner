import 'dart:io';

import 'package:csv/csv.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../../domain/settings/repository/import_export.dart';
import '../../accounts/data_sources/local_account_data_manager.dart';
import '../../accounts/model/account_model.dart';
import '../../category/data_sources/category_local_data_source.dart';
import '../../category/model/category_model.dart';
import '../../expense/data_sources/local_expense_data_manager.dart';
import '../../expense/model/expense_model.dart';

@Named('csv')
@LazySingleton(as: Export)
class CSVExport extends Export {
  CSVExport(
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
  Future<String> export() async {
    final File file = await getTempFile();
    final String csvString = await _fetchAllDataAndEncode();
    await file.writeAsString(csvString);
    return file.path;
  }

  Future<File> getTempFile() async {
    final Directory tempDir = await getTemporaryDirectory();
    return await File('${tempDir.path}/paisa_backup.csv').create();
  }

  Future<String> _fetchAllDataAndEncode() async {
    final List<ExpenseModel> expenses = expenseDataManager.export().toList();
    final List<List<String>> data = csvDataList(expenses);
    final String csvData = const ListToCsvConverter().convert(data);
    return csvData;
  }

  List<List<String>> csvDataList(List<ExpenseModel> expenses) {
    return [
      [
        'No',
        'Expense Name',
        'Amount',
        'Date',
        'Description',
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
          final account = accountDataManager.findById(expense.accountId);
          final category = categoryDataManager.findById(expense.categoryId);
          return expenseRow(
            index,
            expense: expense,
            account: account,
            category: category!,
          );
        },
      ),
    ];
  }

  List<String> expenseRow(
    int index, {
    required ExpenseModel expense,
    required AccountModel? account,
    required CategoryModel? category,
  }) {
    return [
      '$index',
      expense.name,
      '${expense.currency}',
      expense.time.toIso8601String(),
      expense.description ?? '',
      category?.name ?? '',
      category?.description ?? '',
      account?.name ?? '',
      account?.bankName ?? '',
      account?.cardType?.name ?? 'bank',
    ];
  }
}
