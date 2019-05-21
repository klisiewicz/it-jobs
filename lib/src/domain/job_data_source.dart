import 'package:it_jobs/src/domain/job.dart';

abstract class JobDataSource {
  Future<Iterable<Job>> getAll();
}
