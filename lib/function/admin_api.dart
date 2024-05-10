import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soigne_moi_web/config/app_config.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/model/stay.dart';

class AdminApi {
  final storage = FlutterSecureStorage();
  final dio = Dio();

  Future<String> _getToken() async {
    return await storage.read(key: 'access_token') ?? '';
  }

  Future<List<Stay>> fetchAllStays() async {
    final token = await _getToken();
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

  // For a list of doctors
  Future<List<Doctor>> fetchAllDoctors() async {
    final token = await _getToken();
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      final response = await dio.get(
        '/admin/doctors',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> doctorsJson = response.data['doctors'];
        final List<Doctor> doctors =
            doctorsJson.map((json) => Doctor.fromJson(json)).toList();

        return doctors;
      } else {
        throw Exception('Failed to fetch doctors');
      }
    } catch (e) {
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  Future<String?> createDoctor(Doctor doctor, XFile? image) async {
    final token = await _getToken();
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      final Map<String, dynamic> doctorJson = doctor.toJson();

      FormData formData = FormData();

      doctorJson.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      // Adds medicalSections elements one by one
      for (int i = 0; i < doctor.medicalSections.length; i++) {
        formData.fields
            .add(MapEntry('medicalSections[$i]', doctor.medicalSections[i]));
      }

      // If an image is supplied, it is added to the form
      if (image != null) {
        Uint8List data = await image.readAsBytes();
        formData.files.add(
          MapEntry(
            'photo',
            MultipartFile.fromBytes(
              data,
              filename: 'photo.jpg',
              contentType: MediaType('image', 'jpg'),
            ),
          ),
        );
      }

      final response = await dio.post(
        '/admin/doctors/create',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );

      return "success";
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Exception when calling backend log: $e\n");
      }

      // Display Dio error messages to the user
      if (e.response?.data != null) {
        var errorMessage = e.response?.data['message'];
        if (kDebugMode) {
          print("errorMessage: $errorMessage");
        }
        return errorMessage;
      } else {
        return "Erreur réseaux";
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      return "error";
    }
  }
}
