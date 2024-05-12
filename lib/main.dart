import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soigne_moi_web/utils/app_colors.dart';

import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GoRouter router = GoRouter(routes: AppRoutes.routes);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Soigne Moi',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accentColor),
        useMaterial3: true,
      ),
    );
  }
}
