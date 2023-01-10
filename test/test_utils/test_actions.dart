import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Finder
Finder findTextWidget(String str) => find.text(str);

Finder findTypeWidget(Type type) => find.byType(type);

Finder findKeyWidget(dynamic key) => find.byKey(key);//find.descendant(of: find.byKey(key), matching: find.byType(type));


/// Actions

Future<void> tap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump();
}

Future<void> scrollDownToView(WidgetTester tester, Finder finder, Offset? offset) async {
  await _dragUntilVisible(tester, finder, offset ?? const Offset(0, -20));
}

Future<void> _dragUntilVisible(
    WidgetTester tester,
    Finder finder,
    Offset offset,
    ) async {
  await tester.dragUntilVisible(
    finder,
    find.ancestor(
      of: finder,
      matching: find.byWidgetPredicate((widget) => widget is Scrollable),
    ),
    offset,
  );
  await tester.pump();
}


Future<void> waitForAnimation(WidgetTester tester) async {
  return tester.pump(const Duration(milliseconds: 500));
}


///
extension FinderMatchExtension on Finder {
  void never() => expect(this, findsNothing);

  void once() => expect(this, findsOneWidget);

  void times(int n) => expect(this, findsNWidgets(n));
}

