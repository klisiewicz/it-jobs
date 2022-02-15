import 'package:flutter_bloc_patterns/base_list.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:meta/meta.dart';

@immutable
abstract class JobRepository extends ListRepository<Job> {}
