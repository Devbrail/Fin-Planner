import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/settings/file_handler.dart';
import '../widgets/settings_group_card.dart';

class ExportAndImportPage extends StatelessWidget {
  const ExportAndImportPage({super.key});

  Future<void> _fetchAndShareJSONFile(BuildContext context) async {
    final FileHandler fileHandler = getIt.get<FileHandler>();
    fileHandler.fetchXFileJSONToShare().then((xFile) => Share.shareXFiles(
          [xFile],
          subject: context.loc.backupAndRestoreShareTitleLabel,
        ));
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
            title: context.loc.backupAndRestoreJSONTitleLabel,
            options: [
              ListTile(
                title: Text(context.loc.backupAndRestoreJSONDescLabel),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () => _fetchAndShareJSONFile(context),
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
