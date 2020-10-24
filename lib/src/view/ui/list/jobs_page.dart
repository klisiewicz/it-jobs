import 'package:flutter/material.dart';
import 'package:flutter_bloc_patterns/view.dart';
import 'package:it_jobs/src/di/injector.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/view/bloc/jobs_bloc.dart';
import 'package:it_jobs/src/view/ui/common/error_page.dart';
import 'package:it_jobs/src/view/ui/common/loading_indicator.dart';
import 'package:it_jobs/src/view/ui/keys.dart';
import 'package:it_jobs/src/view/ui/list/jobs_list.dart';

class JobsPage extends StatefulWidget {
  const JobsPage() : super(key: Keys.jobsPage);

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
      appBar: AppBar(
        title: const Text('IT Jobs'),
        elevation: 0,
      ),
      body: ViewStateBuilder<List<Job>, JobsBloc>(
        bloc: jobsBloc,
        onLoading: (context) => const LoadingIndicator(),
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
