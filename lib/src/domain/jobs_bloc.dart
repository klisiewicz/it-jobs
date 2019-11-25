import 'package:flutter_bloc_patterns/base_list.dart';
import 'package:it_jobs/src/domain/job.dart';

class JobsBloc extends ListBloc<Job> {
  JobsBloc(ListRepository<Job> repository) : super(repository);
}
