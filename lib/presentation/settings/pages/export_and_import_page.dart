import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/common/enum/box_types.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/constants/extensions.dart';
import '../../../data/settings/file_handler.dart';
import '../../../di/service_locator.dart';
import '../widgets/settings_group_card.dart';

extension FileExtension on FileSystemEntity {
  String? get name {
    return path.split("/").last;
  }
}

class ExportAndImportPage extends StatefulWidget {
  const ExportAndImportPage({super.key});

  @override
  State<ExportAndImportPage> createState() => _ExportAndImportPageState();
}

class _ExportAndImportPageState extends State<ExportAndImportPage> {
  final FileHandler fileHandler = locator.get();

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
                          context.showMaterialSnackBar('Creating backup');
                          await fileHandler.createBackUpFile(
                            () {
                              setState(() {});
                            },
                          );
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
          FutureBuilder<Directory?>(
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
                      onTap: () => fileHandler.restoreBackUpFile(
                          fileSystemEntity: files[index]),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
