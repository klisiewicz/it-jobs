import 'package:flutter/material.dart';
import 'package:it_jobs/src/ui/jobs_page.dart';

class ItJobsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Jobs',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: JobsPage(),
    );
  }
}
