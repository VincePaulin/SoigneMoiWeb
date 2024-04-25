import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soigne_moi_web/config/app_config.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/model/user.dart';

Future<User> fetchUser() async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'access_token');

  final dio = Dio();
  dio.options.baseUrl = AppConfig.baseUrl;

  try {
    final response = await dio.get(
      '/user',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      final userJson = response.data['user'];
      return User.fromJson(userJson);
    } else {
      throw Exception('Failed to fetch user');
    }
  } catch (e) {
    throw Exception('Failed to fetch user: $e');
  }
}

Future<List<Stay>> fetchStays() async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'access_token');

  final dio = Dio();
  dio.options.baseUrl = AppConfig.baseUrl;

  try {
    final response = await dio.get(
      '/user/stays',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> staysJson = response.data['stays'];
      final List<Stay> stays =
          staysJson.map((json) => Stay.fromJson(json)).toList();
      return stays;
    } else {
      throw Exception('Failed to fetch stays');
    }
  } catch (e) {
    throw Exception('Failed to fetch stays: $e');
  }
}
