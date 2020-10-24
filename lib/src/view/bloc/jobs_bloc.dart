import 'package:flutter_bloc_patterns/base_list.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/domain/job_repository.dart';

class JobsBloc extends ListBloc<Job> {
  JobsBloc(JobRepository jobRepository) : super(jobRepository);
}
