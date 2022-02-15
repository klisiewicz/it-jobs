import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/infrastructure/remote/graphql/job_graph_ql_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../domain/entity/job_test_data.dart';
import 'graphql_matchers.dart';

class _GraphQLClientMock extends Mock implements GraphQLClient {}

class JobsQueryOptionsFake extends Fake implements QueryOptions<List<Job>> {}

void main() {
  late JobGraphQLRepository jobGraphQlDataSource;
  late GraphQLClient client;

  setUpAll(() {
    registerFallbackValue(JobsQueryOptionsFake());
  });

  setUp(() {
    client = _GraphQLClientMock();
    jobGraphQlDataSource = JobGraphQLRepository(client);
  });

  Future<QueryResult<List<Job>>> executingGetJobsQuery() {
    return client.query<List<Job>>(
      any(that: usesQueryDocument(JobGraphQLRepository.getAllJobs)),
    );
  }

  final successQueryResult = QueryResult<List<Job>>(
    data: <String, dynamic>{
      'jobs': [
        {
          'slug': 'android',
          'title': 'Android Developer',
          'company': {
            'slug': 'google',
            'name': 'Google',
          },
        },
        {
          'slug': 'java',
          'title': 'Java Developer',
          'company': {
            'slug': 'oracle',
            'name': 'Oracle',
          }
        },
      ],
    },
    source: QueryResultSource.network,
    parserFn: parseJobs,
  );

  test('should return jobs from the client', () async {
    when(executingGetJobsQuery).thenAnswerFutureValue(successQueryResult);

    final jobs = await jobGraphQlDataSource.getAll();
    expect(jobs, hasLength(2));
    expect(jobs.first, androidDeveloper);
    expect(jobs.last, javaDeveloper);
  });
}

extension WhenFutureExt<T> on When<Future<T>> {
  void thenAnswerFutureValue(T value) => thenAnswer((_) async => value);
}
