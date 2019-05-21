import 'package:equatable/equatable.dart';
import 'package:it_jobs/src/domain/job.dart';

abstract class JobsState extends Equatable {
  JobsState([List props = const []]) : super(props);
}

class JobsLoading extends JobsState {}

class JobsLoaded extends JobsState {
  final List<Job> jobs;

  JobsLoaded(this.jobs) : super([jobs]);
}

class JobsNotLoaded extends JobsState {
  final Exception exception;

  JobsNotLoaded(this.exception) : super([exception]);
}
