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
      link: HttpLink('https://api.graphql.jobs/'),
      cache: GraphQLCache(),
    ),
  );
  locator.registerFactory<JobDataSource>(
    () => JobGraphQLDataSource(locator.get()),
  );
  locator.registerLazySingleton(() => JobRepository(locator.get()));
  locator.registerFactory(() => JobsBloc(locator.get()));
}

T inject<T extends Object>([String? name]) {
  return GetIt.instance.get<T>(instanceName: name);
}
