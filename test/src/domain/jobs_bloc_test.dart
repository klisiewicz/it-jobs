import 'package:flutter_test/flutter_test.dart';
import 'package:it_jobs/src/domain/job_repository.dart';
import 'package:it_jobs/src/domain/jobs_actions.dart';
import 'package:it_jobs/src/domain/jobs_bloc.dart';
import 'package:it_jobs/src/domain/jobs_states.dart';
import 'package:mockito/mockito.dart';

import '../data/job_test_data.dart';

class _JobRepositoryMock extends Mock implements JobRepository {}

main() {
  JobsBloc jobsBloc;
  JobRepository jobRepository;

  setUp(() {
    jobRepository = _JobRepositoryMock();
    jobsBloc = JobsBloc(jobRepository);
  });

  givenRepositoryReturningJobs() => when(jobRepository.findAll())
      .thenAnswer((_) async => [androidDeveloper, javaDeveloper]);

  givenRepositoryReturningError() =>
      when(jobRepository.findAll()).thenThrow(_jobsLoadingException);

  whenFetchingJobs() => jobsBloc.dispatch(GetAllJobs());

  thenExpectStates(Iterable<JobsState> states) {
    expectLater(
      jobsBloc.state,
      emitsInOrder(states),
    );
  }

  test('should be initialized in loading state', () {
    thenExpectStates([
      JobsLoading(),
    ]);
  });

  test('should emit jobs from repository', () {
    givenRepositoryReturningJobs();

    thenExpectStates([
      JobsLoading(),
      JobsLoaded([androidDeveloper, javaDeveloper]),
    ]);

    whenFetchingJobs();
  });

  test('should emit jobs from repository', () {
    givenRepositoryReturningError();

    thenExpectStates([
      JobsLoading(),
      JobsNotLoaded(_jobsLoadingException),
    ]);

    whenFetchingJobs();
  });
}

final _jobsLoadingException = Exception('Ooops...');
