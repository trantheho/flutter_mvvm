import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/error/error_page.dart';
import '../../presentation/pages/main_page/main_page.dart';
import 'route_config.dart';

class AppRouter{
  final GoRouter _goRouter;
  GoRouter get goRouter => _goRouter;

  AppRouter()
      : _goRouter = GoRouter(
          debugLogDiagnostics: true,
          initialLocation: AppPage.root.path,
          navigatorKey: RouteConfig.rootKey,
          redirect: RouteConfig.guard,
          errorBuilder: (_, state) => ErrorPage(
            error: state.error.toString(),
          ),
          routes: [
            RouteConfig.buildRoute(AppPage.onBoarding),
            RouteConfig.buildRoute(AppPage.auth),
            ShellRoute(
              builder: (_, state, child) => MainPage(child: child),
              navigatorKey: RouteConfig.nestedKey,
              routes: [
                RouteConfig.buildRoute(AppPage.root),
                RouteConfig.buildRoute(AppPage.home),
                RouteConfig.buildRoute(AppPage.category),
                RouteConfig.buildRoute(AppPage.cart),
                RouteConfig.buildRoute(AppPage.favorite),
                RouteConfig.buildRoute(AppPage.profile),
              ],
            ),
          ],
        );
}