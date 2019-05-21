import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_jobs/src/domain/job.dart';
import 'package:it_jobs/src/ui/jobs_list.dart';

import '../data/job_test_data.dart';
import 'ui_test_util.dart';

main() {
  testWidgets('should display all jobs', (WidgetTester tester) async {
    // Given:
    await tester.pumpWidget(makeTestableWidget(
      child: JobsList(jobs: [androidDeveloper, javaDeveloper]),
    ));

    // Then:
    expectLater(find.byKey(Key(androidDeveloper.slug)), findsOneWidget);
    expectLater(find.byKey(Key(javaDeveloper.slug)), findsOneWidget);
  });

  testWidgets('should select job', (WidgetTester tester) async {
    // Given:
    Job selectedJob;
    await tester.pumpWidget(makeTestableWidget(
      child: JobsList(jobs: [androidDeveloper, javaDeveloper],
        onJobSelected: (job) => selectedJob = job,),
    ));

    // When:
    await tester.tap(find.byKey(Key(javaDeveloper.slug)));

    // Then:
    expect(selectedJob, javaDeveloper);
  });
}
