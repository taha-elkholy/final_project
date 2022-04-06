import 'package:dartz/dartz.dart';
import 'package:final_project/core/failure/failure.dart';

abstract class AppUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
