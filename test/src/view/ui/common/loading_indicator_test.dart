import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_jobs/src/view/ui/common/loading_indicator.dart';

import '../ui_test_util.dart';

void main() {
  testWidgets('should display loading indicator', (WidgetTester tester) async {
    // Given:
    await tester.pumpWidget(
      makeTestableWidget(child: const LoadingIndicator()),
    );

    // Then:
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
