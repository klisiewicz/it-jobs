import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:it_jobs/src/data/job_graph_ql_data_source.dart';
import 'package:it_jobs/src/domain/job_repository.dart';
import 'package:it_jobs/src/domain/jobs_actions.dart';
import 'package:it_jobs/src/domain/jobs_bloc.dart';
import 'package:it_jobs/src/domain/jobs_states.dart';
import 'package:it_jobs/src/ui/common/error_page.dart';
import 'package:it_jobs/src/ui/common/loading_indicator.dart';
import 'package:it_jobs/src/ui/jobs_list.dart';

class JobsPage extends StatefulWidget {
  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  JobsBloc jobsBloc = JobsBloc(JobRepository(JobGraphQLDataSource(GraphQLClient(
      link: HttpLink(uri: 'https://api.graphql.jobs/') as Link,
      cache: NormalizedInMemoryCache(
          dataIdFromObject: typenameDataIdFromObject,
          storageProvider: null)))));

  @override
  void initState() {
    super.initState();
    _fetchAllJobs();
  }

  void _fetchAllJobs() => jobsBloc.dispatch(GetAllJobs());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IT Jobs'),
      ),
      body: BlocBuilder(
        bloc: jobsBloc,
        builder: _buildJobsContent,
      ),
    );
  }

  Widget _buildJobsContent(BuildContext context, JobsState state) {
    if (state is JobsLoading) {
      return LoadingIndicator();
    } else if (state is JobsLoaded) {
      return JobsList(jobs: state.jobs);
    } else if (state is JobsNotLoaded) {
      return ErrorPage(onRetry: _fetchAllJobs);
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    super.dispose();
    jobsBloc.dispose();
  }
}
