import 'package:flutter/material.dart';
import 'package:flutter_bloc_patterns/view.dart';
import 'package:it_jobs/src/di/injector.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/view/bloc/jobs_bloc.dart';
import 'package:it_jobs/src/view/ui/common/error_page.dart';
import 'package:it_jobs/src/view/ui/common/loading_indicator.dart';
import 'package:it_jobs/src/view/ui/list/jobs_list.dart';

class JobsPage extends StatefulWidget {
  static const jobsPage = Key('__jobsPage__');

  const JobsPage() : super(key: jobsPage);

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
        onSuccess: (context, jobs) => RefreshView(
          onRefresh: jobsBloc.refreshElements,
          child: JobsList(jobs: jobs),
        ),
        onRefreshing: (context, jobs) => RefreshView(
          onRefresh: jobsBloc.refreshElements,
          child: JobsList(jobs: jobs),
        ),
        onError: (context, error) => ErrorPage(onRetry: jobsBloc.loadElements),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    jobsBloc.close();
  }
}
