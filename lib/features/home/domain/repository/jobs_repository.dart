import 'package:dartz/dartz.dart';
import 'package:final_project/core/failure/failure.dart';
import 'package:final_project/features/home/domain/entities/apply_sent_entity.dart';
import 'package:final_project/features/home/domain/entities/job.dart';

abstract class JobsRepository {
  Future<Either<Failure, List<Job>>> getJobs();

  Future<Either<Failure, bool>> apply(
      {required ApplySentEntity applySentEntity});
}
