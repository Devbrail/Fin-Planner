import 'package:dartz/dartz.dart';
import 'package:paisa/src/core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, bool>> pickImageAndSave();
}
