import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageTransition extends CustomTransitionPage<void> {
  PageTransition.noTransition({
    required LocalKey key,
    required Widget child,
    Duration? duration,
  }) : super(
          key: key,
          transitionsBuilder: (c, animation, a2, child) => child,
          transitionDuration: duration ?? const Duration(milliseconds: 1),
          child: child,
        );

  PageTransition.fade({
    required LocalKey key,
    required Widget child,
    Duration? duration,
  }) : super(
          key: key,
          transitionsBuilder: (c, animation, a2, child) => FadeTransition(
            opacity: animation.drive(
              CurveTween(curve: Curves.easeIn),
            ),
            child: child,
          ),
          transitionDuration: duration ?? const Duration(milliseconds: 150),
          child: child,
        );

  PageTransition.slide({
    LocalKey? key,
    required Widget child,
  }) : super(
          key: key,
          transitionsBuilder: (_, animation, __, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          child: child,
        );

  PageTransition.fadeThrough({
    LocalKey? key,
    required Widget child,
  }) : super(
          key: key,
          transitionsBuilder: (_, animation, secondAnimation, child) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondAnimation,
              child: child,
            );
          },
          child: child,
        );

  PageTransition.scale({
    LocalKey? key,
    required Widget child,
  }) : super(
    key: key,
    transitionsBuilder: (_, animation, __, child) {
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    },
    child: child,
  );

  PageTransition.sharedAxis({
    LocalKey? key,
    SharedAxisTransitionType? transitionType,
    required Widget child,
    Duration? duration,
  }) : super(
    key: key,
    transitionDuration: duration ?? const Duration(milliseconds: 300),
    transitionsBuilder: (_, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: transitionType ?? SharedAxisTransitionType.horizontal,
        child: child,
      );
    },
    child: child,
  );
}
