import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_mvvm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('full app test', () {
    testWidgets('', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final nextButton = find.byKey(const Key('nextButton')).first;
      await tester.pumpAndSettle();
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      //
      final backButton = find.byKey(const Key('backButton')).first;
      await tester.pumpAndSettle();
      await tester.tap(backButton);
      await tester.pumpAndSettle();
    });
  });
}