import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_jobs/src/ui/job_list_item.dart';

import '../data/job_test_data.dart';
import 'ui_test_util.dart';

void main() {
  testWidgets(
    'should display job title, company name',
    (WidgetTester tester) async {
      // Given:
      await tester.pumpWidget(makeTestableWidget(
        child: JobListItem(job: androidDeveloper),
      ));

      // Then:
      expect(find.text(androidDeveloper.title), findsOneWidget);
      expect(find.text(androidDeveloper.company.name), findsOneWidget);
    },
  );

  testWidgets(
    'should notify when job clicked',
    (WidgetTester tester) async {
      bool wasJobSelected = false;

      // Given:
      await tester.pumpWidget(makeTestableWidget(
        child: JobListItem(
          job: androidDeveloper,
          onJobSelected: () => wasJobSelected = true,
        ),
      ));
      expect(wasJobSelected, isFalse);

      // When:
      await tester.tap(find.byType(InkWell));

      // Then:
      expect(wasJobSelected, isTrue);
    },
  );
}
