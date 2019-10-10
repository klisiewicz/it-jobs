import 'package:flutter_bloc_patterns/base_list.dart';
import 'package:it_jobs/src/domain/job.dart';
import 'package:it_jobs/src/domain/job_data_source.dart';

class JobRepository implements Repository<Job> {
  final JobDataSource _jobDataSource;

  JobRepository(JobDataSource jobDataSource)
      : this._jobDataSource = jobDataSource,
        assert(jobDataSource != null);

  @override
  Future<List<Job>> getAll() async {
    final Iterable<Job> jobs = await _jobDataSource.getAll();
    return jobs;
  }
}
