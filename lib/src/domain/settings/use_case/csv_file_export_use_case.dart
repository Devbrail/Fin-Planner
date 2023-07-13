import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../repository/import_export.dart';
import '../repository/settings_repository.dart';

@singleton
class CSVFileExportUseCase {
  CSVFileExportUseCase(
    this.settingsRepository,
    @Named('csv') this.csvExport,
  );
  final Export csvExport;
  final SettingsRepository settingsRepository;

  Future<Either<Failure, String>> call() =>
      settingsRepository.exportDataToFile(export: csvExport);
}
