import 'dart:ui';

import 'package:flutter_mvvm/core/manager/app_state_manager.dart';
import 'package:flutter_mvvm/my_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils/mocks/mock_local_data_source.dart';
import 'test_utils/test_actions.dart';

const Size screenSize = Size(375, 812);

Future<void> launchApp(WidgetTester tester, {bool loggedIn = false}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await tester.binding.setSurfaceSize(screenSize);
  await tester.pumpWidget(
    AppStateManager(
      localDataSource: MockLocalDataSource(),
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
  await tester.pump();
  await waitForAnimation(tester);
  await tester.pump();
}
