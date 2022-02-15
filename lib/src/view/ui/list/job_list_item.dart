import 'package:flutter/material.dart';
import 'package:it_jobs/src/domain/entity/job.dart';

class JobListItem extends StatelessWidget {
  final Job job;
  final VoidCallback? onJobSelected;

  const JobListItem(
    this.job, {
    Key? key,
    this.onJobSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.title!),
      subtitle: Text(job.company!.name!),
      onTap: onJobSelected,
    );
  }
}
