import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/expense/datasources/expense_manager_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import 'setting_option.dart';

class ExportExpensesWidget extends StatefulWidget {
  const ExportExpensesWidget({Key? key}) : super(key: key);

  @override
  _ExportExpensesWidgetState createState() => _ExportExpensesWidgetState();
}

class _ExportExpensesWidgetState extends State<ExportExpensesWidget> {
  final dataSource = locator.get<ExpenseManagerDataSource>();

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      onTap: () => exportData(),
      title: AppLocalizations.of(context)!.exportExpenses,
      subtitle: AppLocalizations.of(context)!.exportExpensesDescription,
    );
  }

  Future<void> exportData() async {
    final dataSource = locator.get<ExpenseManagerDataSource>();
    final expenses = await dataSource.expenses();
    final data = csvDataList(expenses);
    final csvData = const ListToCsvConverter().convert(data);
    final directory = await getApplicationSupportDirectory();
    final path = "${directory.path}/paisa-expense-manager.csv";
    final file = File(path);
    await file.writeAsString(csvData);
    Share.shareFiles([path],
        subject: AppLocalizations.of(context)!.exportExpenses);
  }
}

List<List<String>> csvDataList(List<Expense> expenses) {
  return [
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
        return [
          '$index',
          expense.name,
          '${expense.currency}',
          expense.time.toIso8601String(),
          expense.category.name,
          expense.category.description,
          expense.account.name,
          expense.account.bankName,
          expense.account.cardType!.name,
        ];
      },
    ),
  ];
}
