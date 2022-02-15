import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/domain/job_repository.dart';

class JobGraphQLRepository extends JobRepository {
  final GraphQLClient _client;

  JobGraphQLRepository(GraphQLClient client) : _client = client;

  @override
  Future<List<Job>> getAll() async {
    final options = _createGetAllJobsQueryOptions();
    final result = await _client.query(options);
    return result.hasData ? result.getJobs() : [];
  }

  static QueryOptions _createGetAllJobsQueryOptions() {
    return QueryOptions(
      document: gql(getAllJobs),
      fetchPolicy: FetchPolicy.cacheFirst,
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
  bool get hasData => data != null;

  List<Job> getJobs() {
    final dynamic jobs = data!['jobs'];
    return (jobs is List)
        ? jobs
            .map((json) => Job.fromJson(json as Map<String, dynamic>))
            .toList()
        : [];
  }
}
