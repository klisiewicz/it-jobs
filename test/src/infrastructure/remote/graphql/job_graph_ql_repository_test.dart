import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:it_jobs/src/infrastructure/remote/graphql/job_graph_ql_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'graphql_matchers.dart';
import '../../../domain/entity/job_test_data.dart';

class _GraphQLClientMock extends Mock implements GraphQLClient {}

class QueryOptionsFake extends Fake implements QueryOptions {}

void main() {
  late JobGraphQLRepository jobGraphQlDataSource;
  late GraphQLClient client;

  setUpAll(() {
    registerFallbackValue(QueryOptionsFake());
  });

  setUp(() {
    client = _GraphQLClientMock();
    jobGraphQlDataSource = JobGraphQLRepository(client);
  });

  Future<QueryResult> executingGetJobsQuery() {
    return client.query(
      any(that: usesQueryDocument(JobGraphQLRepository.getAllJobs)),
    );
  }

  final successQueryResult = QueryResult(
    data: <String, dynamic>{
      'jobs': [
        androidDeveloper.toJson(),
        javaDeveloper.toJson(),
      ],
    },
    source: QueryResultSource.network,
    parserFn: (map) {},
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
