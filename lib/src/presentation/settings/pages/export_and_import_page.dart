import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/settings/file_handler.dart';
import '../widgets/settings_group_card.dart';

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
    await _fetchAndShareJSONFile();
  }

  Future<void> _fetchAndShareJSONFile() async {
    final FileHandler fileHandler = await getIt.getAsync<FileHandler>();
    final XFile xFile = await fileHandler.fetchXFileJSONToShare();
    Share.shareXFiles([xFile], subject: 'Paisa expensive manager file');
  }

  Future<void> _fetchAndShareCSVData() async {
    final FileHandler fileHandler = await getIt.getAsync<FileHandler>();
    final XFile xFile = await fileHandler.fetchXFileJSONToShare();
    Share.shareXFiles([xFile], subject: 'Paisa expensive manager file');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.materialYouAppBar(
        context.loc.backupAndRestoreLabel,
      ),
      body: ListView(
        children: [
          SettingsGroup(
            title: 'Export data as JSON file',
            options: [
              const ListTile(
                title: Text(
                  'The file will be a plain JSON file created and exported to save. Please note that if in case anything changes happen in the future in Paisa then this file will be invalid to import.',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () => _fetchAndShareJSONFile(),
                  label: Text(context.loc.createLabel),
                  icon: const Icon(MdiIcons.fileExport),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  '*The restore option is not implemented as the development not stable',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
