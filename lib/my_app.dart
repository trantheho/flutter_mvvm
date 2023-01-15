import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mvvm/core/manager/app_state_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/app_config.dart';
import 'core/app_controller.dart';
import 'core/manager/locale_manager.dart';
import 'generated/l10n.dart';
import 'presentation/pages/error/error_page.dart';
import 'presentation/widgets/loading.dart';
import 'presentation/widgets/three_bounce_loading.dart';

Future<void> initMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.build(Environment.dev);
  await initLocalDatabase();
  runApp(
    AppStateManager(
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

Future<void> initLocalDatabase() async {
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    appController.loading.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final appState = AppStateManager.of(context);

    return Consumer(
      builder: (_, ref, __) {
        final locale = ref.watch(localeProvider);

        return MaterialApp.router(
          title: 'Flutter Demo',
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: locale,
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: appController.router.goRouter,
          builder: (context, child) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return ErrorPage(
                error: errorDetails.summary.toString(),
              );
            };

            return Stack(
              children: [
                child!,
                if (!appState.initialized) const InitializeApp(),
                const LoadingListenable(),
              ],
            );
          },
        );
      },
    );
  }
}

class LoadingListenable extends StatelessWidget {
  const LoadingListenable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: appController.loading.loadingManager,
      builder: (_, loadingSnapshot, __) => loadingSnapshot ? const AppLoading() : const SizedBox.shrink(),
    );
  }
}

class InitializeApp extends StatelessWidget {
  const InitializeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ThreeBounceLoading(
          color: Colors.blueAccent,
          size: 30,
        ),
      ),
    );
  }
}

