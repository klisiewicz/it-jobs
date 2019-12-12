import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:it_jobs/src/data/job_graph_ql_data_source.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:mockito/mockito.dart';

import 'job_test_data.dart';

class _GraphQLClientMock extends Mock implements GraphQLClient {}

main() {
  JobGraphQLDataSource jobGraphQlDataSource;
  GraphQLClient client;

  setUp(() {
    client = _GraphQLClientMock();
    jobGraphQlDataSource = JobGraphQLDataSource(client);
  });

  test('should return jobs from the client', () async {
    when(client.query(any)).thenAnswer(
      (_) async => QueryResult(
            data: {
              'jobs': [
                androidDeveloper.toJson(),
                javaDeveloper.toJson(),
              ],
            },
          ),
    );

    final List<Job> jobs = (await jobGraphQlDataSource.getAll()).toList();

    expect(jobs.length, 2);
    expect(jobs.first, androidDeveloper);
    expect(jobs.last, javaDeveloper);
  });
}
