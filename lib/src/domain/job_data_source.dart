import 'package:it_jobs/src/domain/entity/job.dart';

abstract class JobDataSource {
  Future<List<Job>> getAll();
}
