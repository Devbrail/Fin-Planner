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

  Future<void> _fetchAndShareJSONFile(BuildContext context) async {
    final FileHandler fileHandler = getIt.get<FileHandler>();

    fileHandler.fetchXFileJSONToShare().then((xFile) => Share.shareXFiles(
          [xFile],
          subject: context.loc.backupAndRestoreShareTitleLabel,
        ));
  }

  Future<void> _selectedFolderAndBackUpData() async {
    final FileHandler fileHandler = getIt.get<FileHandler>();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var statusManageExternalStorage =
        await Permission.manageExternalStorage.request();
    if (statusManageExternalStorage.isGranted &&
        androidInfo.version.sdkInt > 29) {
      return fileHandler.backupIntoFile();
    } else if (androidInfo.version.sdkInt < 30) {
      return fileHandler.backupIntoFile();
    }
  }

  Future<void> _selectedFileAndImportData() async {
    final FileHandler fileHandler = getIt.get<FileHandler>();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var statusManageExternalStorage =
        await Permission.manageExternalStorage.request();
    if (statusManageExternalStorage.isGranted &&
        androidInfo.version.sdkInt > 29) {
      return fileHandler.importFromFile();
    } else if (androidInfo.version.sdkInt < 30) {
      return fileHandler.importFromFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.materialYouAppBar(
        context.loc.backupAndRestoreLabel,
      ),
      bottomNavigationBar: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            '*The restore option is not implemented as the development not stable',
          ),
        ),
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
                          _selectedFileAndImportData()
                              .then((value) => context.showMaterialSnackBar(
                                    context.loc.restoringBackupLabel,
                                  ));
                        },
                        label: Text(context.loc.importDataLabel),
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
                          _selectedFolderAndBackUpData()
                              .then((value) => context.showMaterialSnackBar(
                                    context.loc.creatingBackupLabel,
                                  ));
                        },
                        label: Text(context.loc.exportDataLabel),
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
