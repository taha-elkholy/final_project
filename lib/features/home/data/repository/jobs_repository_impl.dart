import 'package:dartz/dartz.dart';
import 'package:final_project/core/failure/failure.dart';
import 'package:final_project/features/auth/data/data_source/local/auth_local_service.dart';
import 'package:final_project/features/home/data/mappers/jobs_mapper.dart';
import 'package:final_project/features/home/data/services/remote/jobs_service.dart';
import 'package:final_project/features/home/domain/entities/apply_sent_entity.dart';
import 'package:final_project/features/home/domain/entities/job.dart';
import 'package:final_project/features/home/domain/repository/jobs_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: JobsRepository)
class JobsRepositoryImpl extends JobsRepository {
  final JobsService service;
  final AuthLocalService localAuthService;

  JobsRepositoryImpl(this.service, this.localAuthService);

  @override
  Future<Either<Failure, List<Job>>> getJobs() async {
    final _token = localAuthService.getToken();
    try {
      debugPrint('Get Jobs start...');

      if (_token != null && _token.isNotEmpty) {
        final jobsModel = await service.getJobs(token: 'Bearer $_token');

        debugPrint('Get Job user model $jobsModel');

        List<Job> jobs = [];
        if (jobsModel.data != null) {
          for (var element in jobsModel.data!) {
            jobs.add(element.fromModel);
          }
        }
        debugPrint('jobs Length${jobs.length}');
        return right((jobs));
      } else {
        return left(const Failure(message: 'No Token'));
      }
    } catch (error) {
      debugPrint('Get Job failure $error');

      return left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> apply(
      {required ApplySentEntity applySentEntity}) async {
    final _token = localAuthService.getToken();
    final _uId = localAuthService.getUserId();

    try {
      debugPrint('Apply start...$_token');

      if (_token != null && _uId != null) {
        final applyRes = await service.applyForJob(
          token: 'Bearer $_token',
          jobId: applySentEntity.jobId,
          userId: _uId,
          currentSalary: applySentEntity.currentSalary,
          expectedSalary: applySentEntity.expectedSalary,
          cv: applySentEntity.cv,
        );

        debugPrint('Apply Result: $applyRes');

        if (applyRes.first == 'You have applied successfully') {
          return right(true);
        } else {
          debugPrint('Apply Result: $applyRes');

          return left(const Failure(message: 'apply response failure'));
        }
      } else {
        return left(const Failure(message: 'No Token'));
      }
    } catch (error) {
      debugPrint('Apply failure $error');

      return left(Failure(message: error.toString()));
    }
  }
}
