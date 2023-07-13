import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../repository/import_export.dart';
import '../repository/settings_repository.dart';

@singleton
class JSONFileImportUseCase {
  JSONFileImportUseCase(
    this.settingsRepository,
    @Named('json_import') this.jsonImport,
  );

  final Import jsonImport;
  final SettingsRepository settingsRepository;

  Future<Either<Failure, bool>> call() =>
      settingsRepository.importFileToData(import: jsonImport);
}
