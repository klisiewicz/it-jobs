import 'package:bloc/bloc.dart';
import 'package:it_jobs/src/domain/job.dart';
import 'package:it_jobs/src/domain/job_repository.dart';
import 'package:it_jobs/src/domain/jobs_actions.dart';
import 'package:it_jobs/src/domain/jobs_states.dart';

class JobsBloc extends Bloc<JobsAction, JobsState> {
  final JobRepository _jobRepository;

  JobsBloc(JobRepository jobRepository)
      : this._jobRepository = jobRepository,
        assert(jobRepository != null);

  @override
  JobsState get initialState => JobsLoading();

  @override
  Stream<JobsState> mapEventToState(JobsAction action) async* {
    if (action is GetAllJobs) {
      yield* _getAllJobs();
    }
  }

  Stream<JobsState> _getAllJobs() async* {
    try {
      final Iterable<Job> jobs = await _jobRepository.findAll();
      yield JobsLoaded(jobs.toList());
    } catch (e) {
      yield JobsNotLoaded(e);
    }
  }
}
