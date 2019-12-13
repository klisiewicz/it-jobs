import 'package:flutter/material.dart';
import 'package:it_jobs/src/di/injector.dart';
import 'package:it_jobs/src/it_jobs_app.dart';

void main() {
  injectDependencies();
  runApp(ItJobsApp());
}
