import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:go_router/go_router.dart';
import 'package:soigne_moi_web/page/admin/admin_view.dart';
import 'package:soigne_moi_web/page/admin/doctors/create_doctor.dart';
import 'package:soigne_moi_web/page/login/login.dart';
import 'package:soigne_moi_web/page/dashboard_body.dart';
import 'package:soigne_moi_web/page/register/register.dart';
import 'package:soigne_moi_web/utils/screen_size.dart';

abstract class AppRoutes {
  // Method to check if the user is logged in
  static FutureOr<String?> loggedInRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Check connection
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'access_token');
    final role =
        await secureStorage.read(key: 'role'); // Ajout de la lecture du rôle

    if (token != null) {
      if (role != null && role == 'admin') {
        return '/admin'; // Redirect to administration page if user is an administrator
      } else {
        return '/dashboard'; // Redirect to dashboard if user is a normal user
      }
    }
    return null;
  }

  static FutureOr<String?> loggedOutRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Check connection
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'access_token');
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
      path: '/register',
      pageBuilder: (context, state) => defaultPageBuilder(
        context,
        state,
        const Register(),
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
      redirect: loggedOutRedirect,
    ),
    GoRoute(
        path: '/admin',
        pageBuilder: (context, state) => defaultPageBuilder(
              context,
              state,
              AdminView(),
            ),
        redirect: loggedOutRedirect,
        routes: [
          GoRoute(
            path: 'doctors/create',
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              state,
              CreateDoctorPage(),
            ),
            redirect: loggedOutRedirect,
          ),
        ]),
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
