import 'package:graphql/client.dart';
import 'package:it_jobs/src/domain/job.dart';
import 'package:it_jobs/src/domain/job_data_source.dart';

class JobGraphQLDataSource extends JobDataSource {
  final GraphQLClient _client;

  JobGraphQLDataSource(GraphQLClient client)
      : this._client = client,
        assert(client != null);

  @override
  Future<Iterable<Job>> getAll() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: _getAllJobs,
      pollInterval: 10,
      fetchResults: true,
    );

    final QueryResult result = await _client.query(_options);
    final List<dynamic> jobs = result.data['jobs'];
    return jobs.map((json) => Job.fromJson(json));
  }
}

const _getAllJobs = '''
{
  jobs {
    slug
    title
    company {
      slug
      name
    }
    createdAt 
  }
}
''';
