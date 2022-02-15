import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:it_jobs/src/domain/job_repository.dart';
import 'package:it_jobs/src/infrastructure/remote/graphql/job_graph_ql_repository.dart';
import 'package:it_jobs/src/view/bloc/jobs_bloc.dart';

void injectDependencies() {
  final locator = GetIt.instance;
  locator.registerFactory(
    () => GraphQLClient(
      link: HttpLink('https://api.graphql.jobs/'),
      cache: GraphQLCache(),
    ),
  );
  locator.registerLazySingleton<JobRepository>(
    () => JobGraphQLRepository(locator.get()),
  );
  locator.registerFactory(() => JobsBloc(locator.get()));
}

T inject<T extends Object>([String? name]) {
  return GetIt.instance.get<T>(instanceName: name);
}
