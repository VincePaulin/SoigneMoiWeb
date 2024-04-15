import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:soigne_moi_web/page/register/register_view.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterController createState() => RegisterController();
}

class RegisterController extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  bool loading = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
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

  void toggleShowConfirmPassword() =>
      setState(() => showConfirmPassword = !loading && !showConfirmPassword);

  Future<void> register() async {
    setState(() => loading = true);
    try {
      // Make API call to register user
      final response = await dio.post('/auth/register', data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'address': addressController.text,
      });
      // Registration successful
      if (response.statusCode == 201) {
        // Save access token to secure storage
        await secureStorage.write(
            key: 'access_token', value: response.data['access_token']);

        if (mounted) context.go('/');
      } else {
        // Registration failed
        setState(() {
          error = response.data['message'];
        });
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Exception when calling backend log: $e\n");
      }

      // Display Dio error messages to the user
      if (e.response?.data != null) {
        final errorMessage = e.response?.data['message'];
        final error = e.response?.data['errors'][0];
        setState(() => confirmPasswordError = error ?? errorMessage);
      } else {
        setState(() => confirmPasswordError = "Dio error");
      }
      return setState(() => loading = false);
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      setState(() => confirmPasswordError = "error");
      return setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RegisterView(controller: this);
  }
}
