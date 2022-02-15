import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_jobs/src/domain/entity/job.dart';
import 'package:it_jobs/src/view/ui/list/job_list_item.dart';

import '../../../domain/entity/job_test_data.dart';
import '../ui_test_util.dart';

void main() {
  testWidgets(
    'should display job title, company name',
    (WidgetTester tester) async {
      // Given:
      await _makeTestableJobList(tester, androidDeveloper);

      // Then:
      expect(find.text(androidDeveloper.title!), findsOneWidget);
      expect(find.text(androidDeveloper.company!.name!), findsOneWidget);
    },
  );

  testWidgets(
    'should notify when job clicked',
    (WidgetTester tester) async {
      bool wasJobSelected = false;

      // Given:
      await _makeTestableJobList(
        tester,
        androidDeveloper,
        onJobSelected: () => wasJobSelected = true,
      );
      expect(wasJobSelected, isFalse);

      // When:
      await tester.tap(find.byType(InkWell));

      // Then:
      expect(wasJobSelected, isTrue);
    },
  );
}

Future<void> _makeTestableJobList(
  WidgetTester tester,
  Job job, {
  VoidCallback? onJobSelected,
}) async {
  return tester.pumpWidget(
    makeTestableWidget(
      child: JobListItem(
        job,
        onJobSelected: onJobSelected,
      ),
    ),
  );
}
