import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/my_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../app_launcher.dart';
import '../../test_utils/mocks/path_provider_mock.dart';
import '../../test_utils/test_actions.dart';

void main(){
  group('demo app', () {
    setUp(() async {
      PathProviderPlatform.instance = MockPathProviderPlatform();
      final path = await PathProviderPlatform.instance.getApplicationDocumentsPath();
      Hive.init(path);
    });

    final nextButton = findKeyWidget(const Key('nextButton'));

    testWidgets('test onboarding page', (tester) async {
      await launchApp(tester);
      nextButton.once();
    });
  });
}