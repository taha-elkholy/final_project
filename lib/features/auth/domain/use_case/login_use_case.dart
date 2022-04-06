import 'package:dartz/dartz.dart';
import 'package:final_project/core/app_use_case/app_use_case.dart';
import 'package:final_project/core/failure/failure.dart';
import 'package:final_project/features/auth/domain/entities/login_param.dart';
import 'package:final_project/features/auth/domain/entities/user.dart';
import 'package:final_project/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase extends AppUseCase<User, LoginParam> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, User>> call(LoginParam params) {
    return _repository.login(loginParam: params);
  }
}
