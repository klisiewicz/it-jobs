import 'package:flutter_bloc_patterns/base_list.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/domain/job_data_source.dart';

class JobRepository implements ListRepository<Job> {
  final JobDataSource _jobDataSource;

  JobRepository(JobDataSource jobDataSource)
      : _jobDataSource = jobDataSource;

  @override
  Future<List<Job>> getAll() {
    return _jobDataSource.getAll();
  }
}
