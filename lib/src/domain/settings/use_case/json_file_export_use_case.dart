import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../repository/import_export.dart';
import '../repository/settings_repository.dart';

@singleton
class JSONFileExportUseCase {
  JSONFileExportUseCase(
    this.settingsRepository,
    @Named('json_export') this.jsonExport,
  );

  final Export jsonExport;
  final SettingsRepository settingsRepository;

  Future<Either<Failure, String>> call() =>
      settingsRepository.exportDataToFile(export: jsonExport);
}
