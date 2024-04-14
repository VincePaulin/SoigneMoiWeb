import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import 'login_view.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginController createState() => LoginController();
}

class LoginController extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? usernameError;
  String? passwordError;
  bool loading = false;
  bool showPassword = false;
  late final Dio dio;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? error;

  @override
  void initState() {
    super.initState();
    // Initialize dio base options
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8000/api',
      ),
    );
  }

  void toggleShowPassword() =>
      setState(() => showPassword = !loading && !showPassword);

  Future<void> login() async {
    // If all goes well, reset passwordError
    setState(() => passwordError = null);

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        error = 'Email and password are required';
      });
      return;
    }

    setState(() {
      loading = true;
      error = null;
    });

    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        // Store token securely
        await secureStorage.write(
            key: 'token', value: responseData['access_token']);

        if (mounted) context.go('/');
      } else {
        setState(() {
          error = 'Invalid email or password';
        });
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Exception when calling backend log: $e\n");
      }

      // Display Kratos error messages to the user
      if (e.response?.data != null) {
        final errorMessage = e.response?.data['message'];
        setState(() => passwordError = errorMessage);
      } else {
        setState(() => passwordError = "Dio error");
      }
      return setState(() => loading = false);
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      setState(() => passwordError = "error");
      return setState(() => loading = false);
    }

    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return LoginView(
      controller: this,
    );
  }
}
