import 'package:flutter/foundation.dart';

abstract class AppConfig {
  static const String _applicationName = 'Soigne Moi';
  static String get applicationName => _applicationName;

  // API URL
  static const String stagingUrl = 'http://127.0.0.1:8000/api';
  static const String productionUrl = '';
  //TODO: SET URL PROD
  static const String baseUrl = kDebugMode ? stagingUrl : productionUrl;
}
