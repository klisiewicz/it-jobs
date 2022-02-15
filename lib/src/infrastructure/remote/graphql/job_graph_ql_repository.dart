import 'package:graphql/client.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/domain/job_repository.dart';
import 'package:meta/meta.dart';

class JobGraphQLRepository extends JobRepository {
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

  static final _getAllJobsQueryOptions = QueryOptions(
    document: gql(getAllJobs),
    fetchPolicy: FetchPolicy.cacheFirst,
    parserFn: parseJobs,
  );

  final GraphQLClient _client;

  JobGraphQLRepository(GraphQLClient client) : _client = client;

  @override
  Future<List<Job>> getAll() async {
    final result = await _client.query<List<Job>>(_getAllJobsQueryOptions);
    return result.parsedData ?? [];
  }
}

@visibleForTesting
List<Job> parseJobs(Map<String, dynamic> data) {
  final dynamic jobs = data['jobs'];
  return (jobs is List)
      ? jobs.map((json) => Job.fromJson(json as Map<String, dynamic>)).toList()
      : [];
}
