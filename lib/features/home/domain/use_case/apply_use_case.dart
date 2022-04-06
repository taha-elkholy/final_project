import 'package:dartz/dartz.dart';
import 'package:final_project/core/app_use_case/app_use_case.dart';
import 'package:final_project/core/failure/failure.dart';
import 'package:final_project/features/home/domain/entities/apply_sent_entity.dart';
import 'package:final_project/features/home/domain/repository/jobs_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyUseCase extends AppUseCase<bool, ApplySentEntity> {
  final JobsRepository _repository;

  ApplyUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(ApplySentEntity params) {
    return _repository.apply(applySentEntity: params);
  }
}
