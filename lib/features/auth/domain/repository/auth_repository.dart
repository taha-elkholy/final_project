import 'package:dartz/dartz.dart';
import 'package:final_project/core/failure/failure.dart';
import 'package:final_project/features/auth/domain/entities/login_param.dart';
import 'package:final_project/features/auth/domain/entities/register_param.dart';
import 'package:final_project/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({required LoginParam loginParam});

  Future<Either<Failure, User>> register(
      {required RegisterParam registerParam});

  Future<Either<Failure, String>> logout();

  Future<Either<Failure, String>> getToken();
}
