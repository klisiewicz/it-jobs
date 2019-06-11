import 'package:equatable/equatable.dart';

abstract class JobsAction extends Equatable {}

class GetAllJobs extends JobsAction {
  @override
  String toString() => 'GetAllJobs';
}

class RefreshJobs extends JobsAction {
  @override
  String toString() => 'RefreshJobs';
}
