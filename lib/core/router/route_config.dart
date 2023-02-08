import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/domain/models/product_model.dart';
import 'package:flutter_mvvm/presentation/pages/authenticate/auth_action_page/auth_action_page.dart';
import 'package:flutter_mvvm/presentation/pages/categories/categories_page.dart';
import 'package:flutter_mvvm/presentation/pages/checkout/result/checkout_result_page.dart';
import 'package:flutter_mvvm/presentation/pages/deal/deal_page.dart';
import 'package:flutter_mvvm/presentation/pages/deal/detail/item_detail_page.dart';
import 'package:flutter_mvvm/presentation/pages/home/home_page.dart';
import 'package:flutter_mvvm/presentation/pages/profile/profile_page.dart';
import 'package:flutter_mvvm/presentation/pages/shopping_cart/shopping_cart_page.dart';
import 'package:flutter_mvvm/presentation/pages/store/store_page.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/authenticate/auth_page/auth_page.dart';
import '../../presentation/pages/checkout/checkout_page.dart';
import '../../presentation/pages/onboarding/onboarding_page.dart';
import 'page_transitions.dart';

enum AppPage {
  root(path: '/'),
  onBoarding(path: '/onBoarding'),
  auth(path: '/auth'),
  authAction(
    path: ':type',
    params: 'type',
    fullPath: '/auth/:type',
  ),
  home(path: '/home'),
  profile(path: '/profile'),
  category(path: '/category'),
  cart(path: '/cart'),
  checkout(path: 'checkout', fullPath: '/cart/checkout'),
  checkoutResult(path: 'result', fullPath: '/cart/checkout/result'),
  favorite(path: '/favorite'),
  deal(path: ':type', fullPath: '/category/:type', params: 'type'),
  detail(path: ':product', params: 'product');

  const AppPage({
    required this.path,
    this.params = '',
    this.fullPath,
  });

  final String path;
  final String? params;
  final String? fullPath;
}

extension AppPageRoute on AppPage {
  String mapValueToParams(dynamic value) {
    if (this == AppPage.authAction) {
      return AppPage.authAction.fullPath!.replaceAll(':${AppPage.authAction.params}', value ?? '');
    }

    return '';
  }

  GoRoute route() {
    switch (this) {
      case AppPage.root:
        return GoRoute(
          path: path,
          name: name,
          redirect: (_, state) => AppPage.home.path,
        );
      case AppPage.onBoarding:
        return GoRoute(
          path: path,
          name: name,
          builder: (_, state) => const OnBoardingPage(),
        );
      case AppPage.auth:
        return GoRoute(
          path: path,
          name: name,
          builder: (_, state) => const AuthPage(),
          routes: [
            AppPage.authAction.route(),
          ],
        );
      case AppPage.authAction:
        return GoRoute(
          path: path,
          name: name,
          pageBuilder: (_, state) {
            final param = state.params[params] as String;
            final action = AuthAction.values.byName(param);

            return PageTransition.slide(
              key: state.pageKey,
              child: AuthActionPage(authAction: action),
            );
          },
        );
      case AppPage.home:
        return GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) => PageTransition.fadeThrough(
            key: state.pageKey,
            child: const HomePage(),
          ),
        );
      case AppPage.profile:
        return GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) => PageTransition.fadeThrough(
            key: state.pageKey,
            child: const ProfilePage(),
          ),
        );
      case AppPage.deal:
        return GoRoute(
            path: path,
            name: name,
            parentNavigatorKey: RouteConfig.rootKey,
            pageBuilder: (context, state) => PageTransition.fadeThrough(
                  key: state.pageKey,
                  child: DealPage(
                    title: (state.params[params] ?? ''),
                  ),
                ),
            routes: [
              AppPage.detail.route(),
            ]);
      case AppPage.category:
        return GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) => PageTransition.fadeThrough(
            key: state.pageKey,
            child: const CategoryPage(),
          ),
          routes: [
            AppPage.deal.route(),
          ],
        );
      case AppPage.cart:
        return GoRoute(
            path: path,
            name: name,
            pageBuilder: (context, state) => PageTransition.fadeThrough(
                  key: state.pageKey,
                  child: const ShoppingCardPage(),
                ),
            routes: [
              AppPage.checkout.route(),
            ]);
      case AppPage.favorite:
        return GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) => PageTransition.fadeThrough(
            key: state.pageKey,
            child: const StorePage(),
          ),
        );
      case AppPage.detail:
        return GoRoute(
          path: path,
          name: name,
          parentNavigatorKey: RouteConfig.rootKey,
          pageBuilder: (context, state) {
            final product = state.extra as ProductModel;

            return PageTransition.fadeThrough(
              key: state.pageKey,
              child: ItemDetailPage(product: product),
            );
          },
        );
      case AppPage.checkout:
        return GoRoute(
          path: path,
          name: name,
          parentNavigatorKey: RouteConfig.rootKey,
          pageBuilder: (_, state) {
            return PageTransition.fadeThrough(
              key: state.pageKey,
              child: const CheckoutPage(),
            );
          },
          routes: [
            AppPage.checkoutResult.route(),
          ]
        );
      case AppPage.checkoutResult:
        return GoRoute(
            path: path,
            name: name,
            parentNavigatorKey: RouteConfig.rootKey,
            pageBuilder: (_, state) {
              return PageTransition.scale(
                key: state.pageKey,
                child: const CheckoutResultPage(),
              );
            },
        );
      default:
        return GoRoute(
          path: path,
          name: name,
          redirect: (_, state) => AppPage.home.path,
        );
    }
  }
}

class RouteConfig {
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  static GlobalKey<NavigatorState> get rootKey => _rootNavigatorKey;

  static GlobalKey<NavigatorState> get nestedKey => _shellNavigatorKey;

  static GoRoute buildRoute(AppPage page) => page.route();

  static String? guard(BuildContext context, GoRouterState state) {
    final bool loggedIn = context.appState.currentUser != null;
    final bool firstLogin = context.appState.firstLogin;
    final authLocation = state.subloc == AppPage.auth.path;
    final authActionLocation = state.subloc == AppPage.authAction.mapValueToParams('');
    final loginAction = state.subloc == AppPage.authAction.mapValueToParams('login');
    final registerAction = state.subloc == AppPage.authAction.mapValueToParams('register');

    if (firstLogin) {
      return AppPage.onBoarding.path;
    }

    if (!loggedIn) {
      if (authLocation) return null;

      if (!authLocation && authActionLocation) return AppPage.auth.path;

      if (!authLocation && !authActionLocation && loginAction || registerAction) {
        return null;
      } else {
        return AppPage.auth.path;
      }
    }

    if (loggedIn && loginAction) {
      return AppPage.root.path;
    }

    return null;
  }
}
