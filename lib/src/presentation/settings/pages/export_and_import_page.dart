import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/src/presentation/settings/cubit/data_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/settings/file_handler.dart';
import '../../widgets/paisa_annotate_region_widget.dart';
import '../widgets/settings_group_card.dart';

class ExportAndImportPage extends StatelessWidget {
  const ExportAndImportPage({super.key});

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
      if (await Permission.storage.request().isGranted) {
        return fileHandler.backupIntoFile();
      }
    }
    return false;
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
      if (await Permission.storage.request().isGranted) {
        return fileHandler.importFromFile();
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final DataCubit dataCubit = getIt.get();
    return PaisaAnnotatedRegionWidget(
      color: Theme.of(context).colorScheme.background,
      child: BlocListener(
        bloc: dataCubit,
        listener: (context, state) {
          if (state is DataSuccess) {
            context.showMaterialSnackBar(context.loc.restoringBackupSuccess);
          } else if (state is DataError) {
            context.showMaterialSnackBar(state.error);
          } else if (state is DataLoading) {
            context.showMaterialSnackBar(context.loc.restoringBackup);
          }
        },
        child: Scaffold(
          appBar: context
              .materialYouAppBar(context.loc.backupAndRestoreTitle, actions: [
            BlocBuilder(
              bloc: dataCubit,
              builder: (context, state) {
                if (state is DataLoading) {
                  return const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(width: 16),
          ]),
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
                              dataCubit.importDataFromJSON();
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
                              _selectedFolderAndBackUpData().then((value) {
                                if (value) {
                                  return context.showMaterialSnackBar(
                                    context.loc.creatingBackup,
                                  );
                                } else {
                                  return context.showMaterialSnackBar(
                                    'Error backing ',
                                  );
                                }
                              });
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
        ),
      ),
    );
  }
}
