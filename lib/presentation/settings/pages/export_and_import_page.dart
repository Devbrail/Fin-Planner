import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/presentation/settings/widgets/export_expenses_widget.dart';
import 'package:flutter_paisa/presentation/settings/widgets/setting_option.dart';
import 'package:flutter_paisa/presentation/settings/widgets/settings_group_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../data/settings/file_handler.dart';
import '../../../di/service_locator.dart';

class ExportAndImportPage extends StatelessWidget {
  ExportAndImportPage({super.key});

  final FileHandler fileHandler = locator.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: materialYouAppBar(
        context,
        AppLocalizations.of(context)!.backupAndRestoreLabel,
      ),
      body: Column(
        children: [
          SettingsGroup(
            title: 'Backup as JSON file',
            options: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                        onPressed: () async {
                          showMaterialSnackBar(context, 'Creating backup');
                          await fileHandler.createBackUpFile();
                        },
                        label: Text(AppLocalizations.of(context)!.createLabel),
                        icon: const Icon(MdiIcons.fileExport),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => fileHandler.restoreBackUpFile(),
                        label: Text(AppLocalizations.of(context)!.restoreLabel),
                        icon: const Icon(MdiIcons.fileImport),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
