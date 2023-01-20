import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/context_extensions.dart';
import '../../../core/enum/card_type.dart';
import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/accounts/model/account.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';
import '../../../data/settings/file_handler.dart';
import '../../../service_locator.dart';
import '../widgets/settings_group_card.dart';

extension FileExtension on FileSystemEntity {
  String? get name {
    return path.split("/").last;
  }
}

class ExportAndImportPage extends StatelessWidget {
  const ExportAndImportPage({super.key});

  Future<void> _pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 3)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
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
    await _fetchAndShareJSONData();
  }

  Future<void> _fetchAndShareJSONData() async {
    final FileHandler fileHandler = await locator.getAsync<FileHandler>();
    final jsonString = await fileHandler.fetchExpensesAndEncode();

    final directory = await getTemporaryDirectory();
    final File jsonFile = File(
        '${directory.path}/paisa_manager_${DateTime.now().toIso8601String()}.json');
    await jsonFile.writeAsBytes(jsonString.codeUnits);

    Share.shareFiles([jsonFile.path], subject: 'Paisa expensive manager file');
  }

  Future<void> _fetchAndShareCSVData() async {
    final FileHandler fileHandler = await locator.getAsync<FileHandler>();
    final jsonString = await fileHandler.fetchExpensesAndEncode();

    final directory = await getTemporaryDirectory();
    final File jsonFile = File(
        '${directory.path}/paisa_manager_${DateTime.now().toIso8601String()}.csv');
    await jsonFile.writeAsBytes(jsonString.codeUnits);

    Share.shareFiles([jsonFile.path], subject: 'Paisa expensive manager file');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.materialYouAppBar(
        AppLocalizations.of(context)!.backupAndRestoreLabel,
      ),
      body: ListView(
        children: [
          SettingsGroup(
            title: 'Backup as JSON file',
            options: [
              /* const ListTile(
                title: Text(
                  'Restore will clear all the existing data and replace with imported data',
                ),
              ), */
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () => _fetchAndShareJSONData(),
                        label: Text(AppLocalizations.of(context)!.createLabel),
                        icon: const Icon(MdiIcons.fileExport),
                      ),
                    ),
                    /*  const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final FileHandler fileHandler =
                              await locator.getAsync<FileHandler>();
                          fileHandler.restoreBackUpFile();
                        },
                        label: Text(AppLocalizations.of(context)!.restoreLabel),
                        icon: const Icon(MdiIcons.fileImport),
                      ),
                    ), */
                  ],
                ),
              ),
            ],
          ),
          SettingsGroup(
            title: 'Backup as CSV file',
            options: [
              /*  const ListTile(
                title: Text(
                  'Restore will clear all the existing data and replace with imported data',
                ),
              ), */
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () => _fetchAndShareCSVData(),
                        label: Text(AppLocalizations.of(context)!.createLabel),
                        icon: const Icon(MdiIcons.fileExport),
                      ),
                    ),
                    /*  const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final FileHandler fileHandler =
                              await locator.getAsync<FileHandler>();
                          fileHandler.restoreBackUpFile();
                        },
                        label: Text(AppLocalizations.of(context)!.restoreLabel),
                        icon: const Icon(MdiIcons.fileImport),
                      ),
                    ), */
                  ],
                ),
              ),
            ],
          ),
          /* FutureBuilder<Directory?>(
            future: getExternalStorageDirectory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final files = snapshot.data!.listSync();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(files[index].name.toString()),
                      onTap: () async {
                        final FileHandler fileHandler =
                            await locator.getAsync<FileHandler>();
                        await fileHandler.restoreBackUpFile(
                            fileSystemEntity: files[index]);
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ) */
        ],
      ),
    );
  }

  List<List<String>> csvDataList(
    List<Expense> expenses,
    LocalAccountManagerDataSource accountDataSource,
    LocalCategoryManagerDataSource categoryDataSource,
  ) =>
      [
        [
          'No',
          'Transaction',
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
            final category =
                categoryDataSource.fetchCategory(expense.categoryId);
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
        account.cardType!.nameString,
      ];
}
