import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../domain/settings/repository/settings_repository.dart';
import '../file_handler.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(
    this.fileHandler,
    @Named('settings') this.settings,
  );

  final FileHandler fileHandler;
  final Box<dynamic> settings;

  @override
  Future<void> delete(String key) => settings.delete(key);

  @override
  Future<Either<Failure, String>> exportJSONToFile() async {
    try {
      final String path = await fileHandler.writeDataIntoFile();
      if (path.isEmpty) {
        return left(FileNotFoundFailure());
      }
      return right(path);
    } catch (err) {
      return left(ErrorFileExportFailure());
    }
  }

  @override
  T get<T>(String key, {dynamic defaultValue}) =>
      settings.get(key, defaultValue: defaultValue);

  @override
  Future<Either<Failure, bool>> importFileToJSON() async {
    try {
      final bool result = await fileHandler.importDataFromFile();
      return right(result);
    } on FileNotFoundException {
      return left(FileNotFoundFailure());
    } on ErrorFileException {
      return left(ErrorFileExportFailure());
    }
  }

  @override
  Future<void> put(String key, value) => settings.put(key, value);
}
