import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/dashboard_body.dart';
import 'package:soigne_moi_web/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soigne Moi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accentColor),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}
