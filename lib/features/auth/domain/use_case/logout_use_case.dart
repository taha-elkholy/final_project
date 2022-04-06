import 'package:dartz/dartz.dart';
import 'package:final_project/core/app_use_case/app_use_case.dart';
import 'package:final_project/core/failure/failure.dart';
import 'package:final_project/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase extends AppUseCase<String, NoParams> {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return _repository.logout();
  }
}
