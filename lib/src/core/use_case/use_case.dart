import 'package:dartz/dartz.dart';
import 'package:paisa/src/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class NoParams {}
