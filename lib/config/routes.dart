import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:soigne_moi_web/page/auth/login_view.dart';
import 'package:soigne_moi_web/utils/screen_size.dart';

abstract class AppRoutes {
  // static FutureOr<String?> loggedInRedirect(
  //     BuildContext context,
  //     GoRouterState state,
  //     ) async {
  //   // Check connection
  //
  //   return null;
  // }

  // static FutureOr<String?> loggedOutRedirect(
  //     BuildContext context,
  //     GoRouterState state,
  //     ) async {
  //   // Check connection
  //   return null;
  // }

  AppRoutes();

  static final List<RouteBase> routes = [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/login',
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => defaultPageBuilder(
        context,
        state,
        const LoginView(),
      ),
      //redirect: loggedInRedirect,
    ),
  ];

  static Page defaultPageBuilder(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) =>
      ScreenSizeUtil.isSmallScreen(context)
          ? CustomTransitionPage(
              key: state.pageKey,
              restorationId: state.pageKey.value,
              child: child,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            )
          : MaterialPage(
              key: state.pageKey,
              restorationId: state.pageKey.value,
              child: child,
            );
}
