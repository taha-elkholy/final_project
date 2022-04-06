import 'dart:io';

import 'package:dio/dio.dart';
import 'package:final_project/core/const/constants.dart';
import 'package:final_project/features/home/data/models/jobs/jobs_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'jobs_service.g.dart';

@singleton
@RestApi()
abstract class JobsService {
  @factoryMethod
  factory JobsService(Dio dio) = _JobsService;

  @GET(jobsEndPoint)
  Future<JobsModel> getJobs(
      {@Header(authorizationHeader) required String token});

  @POST(appliedJobEndPoint)
  @MultiPart()
  Future<List<String>> applyForJob({
    @Part(name: 'Authorization') required String token,
    @Part(name: 'user_id') required int userId,
    @Part(name: 'job_id') required int jobId,
    @Part(name: 'current_salary') required int currentSalary,
    @Part(name: 'expected_salary') required int expectedSalary,
    @Part(name: 'cv') required File cv,
  });
}
