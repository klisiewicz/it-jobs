import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/domain/job_data_source.dart';

class JobGraphQLDataSource extends JobDataSource {
  final GraphQLClient _client;

  JobGraphQLDataSource(GraphQLClient client)
      : _client = client,
        assert(client != null);

  @override
  Future<List<Job>> getAll() async {
    final WatchQueryOptions options = _createGetAllJobsQueryOptions();
    final QueryResult result = await _client.query(options);
    return result.getJobs();
  }

  static WatchQueryOptions _createGetAllJobsQueryOptions() {
    return WatchQueryOptions(
      documentNode: gql(getAllJobs),
      pollInterval: 10,
      fetchResults: true,
    );
  }

  @visibleForTesting
  static const getAllJobs = '''
  query GetJobs {
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
}

extension on QueryResult {
  List<Job> getJobs() {
    final dynamic jobs = data['jobs'];
    return (jobs is List)
        ? jobs
            .map((json) => Job.fromJson(json as Map<String, dynamic>))
            .toList()
        : [];
  }
}
