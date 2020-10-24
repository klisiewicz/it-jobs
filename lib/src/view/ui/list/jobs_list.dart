import 'package:flutter/material.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/view/ui/list/job_list_item.dart';

typedef JobSelection = void Function(Job job);

class JobsList extends StatelessWidget {
  final List<Job> jobs;
  final JobSelection onJobSelected;

  const JobsList({
    Key key,
    this.jobs = const [],
    this.onJobSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final Job job = jobs[index];
        return JobListItem(
          job,
          key: Key(job.slug),
          onJobSelected: () => onJobSelected.call(job),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: jobs.length,
    );
  }
}
