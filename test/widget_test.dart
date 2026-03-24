import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_version_2/core/di/di_service.dart';
import 'package:portfolio_version_2/main.dart';

void main() {
  setUp(() async {
    await DiService.getIt.reset();
    await DiService.setup();
  });

  testWidgets('loads portfolio hero content', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Your Name'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey<String>('book_page_dot_2')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Skills'), findsOneWidget);
  });
}
