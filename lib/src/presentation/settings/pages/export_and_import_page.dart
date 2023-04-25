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

  Future<bool> _selectedFolderAndBackUpData() async {
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
    return false;
  }

  Future<List<Iterable<int>>> _selectedFileAndImportData() async {
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
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              context.loc.backupAndRestoreLabel,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
                                _selectedFileAndImportData().then((value) {
                                  if (value.isEmpty) {
                                    return context.showMaterialSnackBar(
                                      'Error restore backup ',
                                    );
                                  } else {
                                    return context.showMaterialSnackBar(
                                      context.loc.restoringBackupLabel,
                                    );
                                  }
                                });
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
                                _selectedFolderAndBackUpData().then((value) {
                                  if (value) {
                                    return context.showMaterialSnackBar(
                                      context.loc.creatingBackupLabel,
                                    );
                                  } else {
                                    return context.showMaterialSnackBar(
                                      'Error backing ',
                                    );
                                  }
                                });
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
          )
        ],
      ),
    );
  }
}
