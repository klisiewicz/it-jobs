import 'package:flutter_test/flutter_test.dart';
import 'package:it_jobs/src/ui/common/error_page.dart';
import 'package:it_jobs/src/ui/common/loading_indicator.dart';
import 'package:it_jobs/src/ui/keys.dart';
import 'package:it_jobs/src/ui/list/job_list_item.dart';
import 'package:it_jobs/src/ui/list/jobs_list.dart';
import 'package:it_jobs/src/ui/list/jobs_page.dart';

import '../ui_test_util.dart';

void main() {
  testWidgets('should display loading indicator when waiting for data',
      (WidgetTester tester) async {
    await makeTestableJobPage(tester);

    expect(find.byType(LoadingIndicator), findsOneWidget);
  });

  testWidgets('should display job offers', (WidgetTester tester) async {
    await makeTestableJobPage(tester);

    expect(find.byType(JobsList), findsOneWidget);
    expect(find.byType(JobListItem), findsNWidgets(2));
  });

  testWidgets('should error screen when unable to get offers',
      (WidgetTester tester) async {
    await makeTestableJobPage(tester);

    expect(find.byType(ErrorPage), findsOneWidget);
  });

  testWidgets('should refetch jobs when refresh is pressed',
          (WidgetTester tester) async {
        await makeTestableJobPage(tester);

        await tester.tap(find.byKey(Keys.refreshButton));
        
      });
}

Future<void> makeTestableJobPage(WidgetTester tester) {
  return tester.pumpWidget(
    makeTestableWidget(
      child: JobsPage(),
    ),
  );
}
