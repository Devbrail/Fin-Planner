import 'package:dartz/dartz.dart';
import 'package:paisa/src/core/error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, String>> exportJSONToFile();
  Future<Either<Failure, bool>> importFileToJSON();

  T get<T>(String key, {dynamic defaultValue});

  Future<void> put(String key, dynamic value);

  Future<void> delete(String key);
}
