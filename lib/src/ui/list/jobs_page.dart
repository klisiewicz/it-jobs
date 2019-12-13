import 'package:flutter/material.dart';
import 'package:flutter_bloc_patterns/base_list.dart';
import 'package:it_jobs/src/di/injector.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/domain/jobs_bloc.dart';
import 'package:it_jobs/src/ui/common/error_page.dart';
import 'package:it_jobs/src/ui/common/loading_indicator.dart';
import 'package:it_jobs/src/ui/keys.dart';
import 'package:it_jobs/src/ui/list/jobs_list.dart';

class JobsPage extends StatefulWidget {
  JobsPage({Key key}) : super(key: Keys.jobsPage);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  JobsBloc jobsBloc = inject<JobsBloc>();

  @override
  void initState() {
    super.initState();
    jobsBloc.loadElements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IT Jobs')),
      body: ViewStateBuilder(
        bloc: jobsBloc,
        onLoading: (context) => LoadingIndicator(),
        onSuccess: (context, jobs) => _buildJobsList(jobs),
        onRefreshing: (context, jobs) => _buildJobsList(jobs),
        onError: (context, error) => ErrorPage(onRetry: jobsBloc.loadElements),
      ),
    );
  }

  Widget _buildJobsList(List<Job> jobs) {
    return RefreshView(
      onRefresh: jobsBloc.refreshElements,
      child: JobsList(jobs: jobs),
    );
  }

  @override
  void dispose() {
    super.dispose();
    jobsBloc.close();
  }
}
