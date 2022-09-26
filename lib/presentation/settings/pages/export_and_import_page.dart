import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/common/constants/util.dart';
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
        AppLocalizations.of(context)!.backupAndRestoreLable,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () async {
                  showMaterialSnackBar(context, 'Creating backup');
                  await fileHandler.createBackUpFile();
                },
                label: Text(AppLocalizations.of(context)!.createLable),
                icon: const Icon(MdiIcons.fileExport),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => fileHandler.restoreBackUpFile(),
                label: Text(AppLocalizations.of(context)!.restoreLable),
                icon: const Icon(MdiIcons.fileImport),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
