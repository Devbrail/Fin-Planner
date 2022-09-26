import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/data_sources/expense_manager_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import 'setting_option.dart';

class ExportExpensesWidget extends StatefulWidget {
  const ExportExpensesWidget({Key? key}) : super(key: key);

  @override
  ExportExpensesWidgetState createState() => ExportExpensesWidgetState();
}

class ExportExpensesWidgetState extends State<ExportExpensesWidget> {
  final dataSource = locator.get<ExpenseManagerLocalDataSource>();
  final accountDataSource = locator.get<AccountLocalDataSource>();
  final categoryDataSource = locator.get<CategoryLocalDataSource>();
  DateTimeRange? dateTimeRange;
  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      onTap: () => exportData('Export'),
      title: AppLocalizations.of(context)!.saveAsCSVLabel,
      subtitle: AppLocalizations.of(context)!.saveAsCSVDescLabel,
    );
  }

  Future<void> exportData(String subject) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 3)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateTimeRange ?? initialDateRange,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (_, child) {
        return Theme(
          data: ThemeData.from(colorScheme: Theme.of(context).colorScheme)
              .copyWith(
            appBarTheme: Theme.of(context).appBarTheme,
          ),
          child: child!,
        );
      },
    );
    if (newDateRange == null) return;
    dateTimeRange = newDateRange;
    final expenses = await dataSource.filteredExpenses(dateTimeRange!);
    final data = csvDataList(expenses, accountDataSource, categoryDataSource);
    final csvData = const ListToCsvConverter().convert(data);
    final directory = await getApplicationSupportDirectory();
    final path = "${directory.path}/paisa-expense-manager.csv";
    final file = File(path);
    await file.writeAsString(csvData);
    Share.shareFiles([path], subject: subject);
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
  AccountLocalDataSource accountDataSource,
  CategoryLocalDataSource categoryDataSource,
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
