import 'package:final_project/features/home/data/models/jobs/jobs_model.dart';
import 'package:final_project/features/home/domain/entities/job.dart';

extension JobsMapper on JobData {
  Job get fromModel => Job(
      name: jobName ?? 'No Name',
      description: description ?? 'No Description',
      id: id,
      publishedDate: publishedDate ?? 'No Date');
}
