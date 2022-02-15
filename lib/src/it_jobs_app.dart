import 'package:flutter/material.dart';
import 'package:it_jobs/src/view/ui/list/jobs_page.dart';

class ItJobsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Jobs',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: const ColorScheme.light(
          secondary: Colors.pink,
        ),
      ),
      home: const JobsPage(),
    );
  }
}
