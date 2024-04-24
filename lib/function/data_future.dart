import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soigne_moi_web/model/user.dart';

Future<User> fetchUser() async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'access_token');

  final dio = Dio();
  dio.options.baseUrl = 'http://127.0.0.1:8000/api';

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
