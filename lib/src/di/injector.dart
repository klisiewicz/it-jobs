import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:it_jobs/src/data/job_graph_ql_data_source.dart';
import 'package:it_jobs/src/domain/job_data_source.dart';
import 'package:it_jobs/src/domain/job_repository.dart';
import 'package:it_jobs/src/view/bloc/jobs_bloc.dart';

void injectDependencies() {
  final locator = GetIt.instance;
  locator.registerFactory(
    () => GraphQLClient(
      link: HttpLink(uri: 'https://api.graphql.jobs/'),
      cache: NormalizedInMemoryCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
    ),
  );
  locator.registerFactory<JobDataSource>(
    () => JobGraphQLDataSource(locator.get()),
  );
  locator.registerLazySingleton(() => JobRepository(locator.get()));
  locator.registerFactory(() => JobsBloc(locator.get()));
}

T inject<T>([String name]) => GetIt.instance.get<T>(instanceName: name);
