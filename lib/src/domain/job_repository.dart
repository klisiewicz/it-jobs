import 'package:it_jobs/src/domain/job.dart';
import 'package:it_jobs/src/domain/job_data_source.dart';

class JobRepository {
  final JobDataSource _jobDataSource;

  JobRepository(JobDataSource jobDataSource)
      : this._jobDataSource = jobDataSource,
        assert(jobDataSource != null);

  Future<Iterable<Job>> findAll() async {
    final Iterable<Job> jobs = await _jobDataSource.getAll();
    return jobs;
  }
}
