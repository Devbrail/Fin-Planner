import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/settings/file_handler.dart';
import '../widgets/settings_group_card.dart';

class ExportAndImportPage extends StatelessWidget {
  const ExportAndImportPage({super.key});

  Future<void> _fetchAndShareJSONFile(String title) async {
    final FileHandler fileHandler = getIt.get<FileHandler>();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt < 30) {
      if (await Permission.storage.request().isGranted) {
        fileHandler.backupIntoFile();
      }
    } else {
      final XFile xFile = await fileHandler.fetchXFileJSONToShare();
      Share.shareXFiles(
        [xFile],
        subject: title,
      );
    }
  }

  Future<List<Iterable<int>>> _selectedFileAndImportData() async {
    final FileHandler fileHandler = getIt.get<FileHandler>();

    return fileHandler.importFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.materialYouAppBar(context.loc.backupAndRestoreTitle),
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SettingsGroup(
            title: context.loc.backupAndRestoreJSONTitle,
            options: [
              ListTile(
                title: Text(context.loc.backupAndRestoreJSONDesc),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          elevation: 0,
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          _selectedFileAndImportData().then((value) {
                            if (value.isEmpty) {
                              return context.showMaterialSnackBar(
                                'Error restore backup ',
                              );
                            } else {
                              return context.showMaterialSnackBar(
                                context.loc.restoringBackup,
                              );
                            }
                          });
                        },
                        label: Text(context.loc.importData),
                        icon: const Icon(MdiIcons.fileImport),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          _fetchAndShareJSONFile(
                              context.loc.backupAndRestoreJSONTitle);
                        },
                        label: Text(context.loc.exportData),
                        icon: const Icon(MdiIcons.fileExport),
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
