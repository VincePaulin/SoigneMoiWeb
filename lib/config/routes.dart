import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:go_router/go_router.dart';
import 'package:soigne_moi_web/page/auth/login.dart';
import 'package:soigne_moi_web/page/dashboard_body.dart';
import 'package:soigne_moi_web/utils/screen_size.dart';

abstract class AppRoutes {
  // Method to check if the user is logged in
  static FutureOr<String?> loggedInRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Check connection
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'token');
    if (token != null) return '/dashboard';
    return null;
  }

  static FutureOr<String?> loggedOutRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Check connection
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'token');
    if (token == null) return '/login';

    return null;
  }

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
        const Login(),
      ),
      redirect: loggedInRedirect,
    ),
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) => defaultPageBuilder(
        context,
        state,
        const DashboardPage(),
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
