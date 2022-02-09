import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/data/accounts/datasources/account_data_source.dart';
import 'package:flutter_paisa/data/accounts/model/account.dart';
import 'package:flutter_paisa/data/category/datasources/category_datasource.dart';
import 'package:flutter_paisa/data/category/model/category.dart';
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
  final accountDataSource = locator.get<AccountDataSource>();
  final categoryDataSource = locator.get<CategoryDataSource>();

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      onTap: () => exportData(),
      title: AppLocalizations.of(context)!.exportExpenses,
      subtitle: AppLocalizations.of(context)!.exportExpensesDescription,
    );
  }

  Future<void> exportData() async {
    final expenses = await dataSource.expenses();
    final data = csvDataList(expenses, accountDataSource, categoryDataSource);
    final csvData = const ListToCsvConverter().convert(data);
    final directory = await getApplicationSupportDirectory();
    final path = "${directory.path}/paisa-expense-manager.csv";
    final file = File(path);
    await file.writeAsString(csvData);
    Share.shareFiles([path],
        subject: AppLocalizations.of(context)!.exportExpenses);
  }
}

List<String> expenseRow(
  int index, {
  required Expense expense,
  required Account account,
  required Category category,
}) {
  return [
    '$index',
    expense.name,
    '${expense.currency}',
    expense.time.toIso8601String(),
    category.name,
    category.description,
    account.name,
    account.bankName,
    account.cardType!.name,
  ];
}

List<List<String>> csvDataList(
  List<Expense> expenses,
  AccountDataSource accountDataSource,
  CategoryDataSource categoryDataSource,
) {
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
        final account = accountDataSource.fetchAccount(expense.accountId);
        final category = categoryDataSource.fetchCategory(expense.categoryId);
        return expenseRow(
          index,
          expense: expense,
          account: account,
          category: category,
        );
      },
    ),
  ];
}
