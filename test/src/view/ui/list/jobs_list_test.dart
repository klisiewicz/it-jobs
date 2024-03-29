import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/view/ui/list/jobs_list.dart';

import '../../../domain/entity/job_test_data.dart';
import '../ui_test_util.dart';

void main() {
  testWidgets('should display all jobs', (WidgetTester tester) async {
    // Given:
    await tester.pumpWidget(
      makeTestableWidget(
        child: const JobsList(jobs: [androidDeveloper, javaDeveloper]),
      ),
    );

    // Then:
    await expectLater(find.byKey(Key(androidDeveloper.slug!)), findsOneWidget);
    await expectLater(find.byKey(Key(javaDeveloper.slug!)), findsOneWidget);
  });

  testWidgets('should select job', (WidgetTester tester) async {
    // Given:
    Job? selectedJob;
    await tester.pumpWidget(
      makeTestableWidget(
        child: JobsList(
          jobs: const [androidDeveloper, javaDeveloper],
          onJobSelected: (job) => selectedJob = job,
        ),
      ),
    );

    // When:
    await tester.tap(find.byKey(Key(javaDeveloper.slug!)));

    // Then:
    expect(selectedJob, javaDeveloper);
  });
}
