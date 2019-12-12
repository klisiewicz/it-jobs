import 'package:it_jobs/src/domain/entity/company.dart';
import 'package:it_jobs/src/domain/entity/job.dart';

final androidDeveloper = Job(
  slug: 'android',
  title: 'Android Developer',
  company: Company(
    slug: 'google',
    name: 'Google',
  ),
);

final javaDeveloper = Job(
  slug: 'java',
  title: 'Java Developer',
  company: Company(
    slug: 'oracle',
    name: 'Oracle',
  ),
);
