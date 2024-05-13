import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soigne_moi_web/config/app_config.dart';
import 'package:soigne_moi_web/model/agenda.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/model/stay.dart';

class AdminApi {
  final storage = FlutterSecureStorage();
  final dio = Dio();

  // Function to generate options with authentication token and JSON acceptance
  Future<Options> _generateOptions() async {
    final token = await _getToken();
    return Options(headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
  }

  // How to retrieve the token
  Future<String> _getToken() async {
    return await storage.read(key: 'access_token') ?? '';
  }

  Future<String?> getUserFullName(String userId) async {
    try {
      dio.options.baseUrl = AppConfig.baseUrl;

      // Define query data
      Map<String, dynamic> formData = {'user_id': userId};

      // Send GET request
      final response = await dio.get(
        '/admin/user-name',
        queryParameters: formData,
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        // Extract the full name of the answer
        String fullName = response.data['full_name'];
        return fullName;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to fetch user name',
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return null;
  }

  // Method for retrieving all stays
  Future<List<Stay>?> fetchAllStays() async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      final response = await dio.get(
        '/user/stays',
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> staysJson = response.data['stays'];
        final List<Stay> stays =
            staysJson.map((json) => Stay.fromJson(json)).toList();
        return stays;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to fetch stays',
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return null;
  }

  // How to retrieve all doctors
  Future<List<Doctor>?> fetchAllDoctors() async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      final response = await dio.get(
        '/admin/doctors',
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> doctorsJson = response.data['doctors'];
        final List<Doctor> doctors =
            doctorsJson.map((json) => Doctor.fromJson(json)).toList();

        return doctors;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to fetch doctors',
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return null;
  }

  // How to create a doctor
  Future<String?> createDoctor(Doctor doctor, XFile? image) async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      // Data construction for the query
      final Map<String, dynamic> doctorJson = doctor.toJson();
      FormData formData = FormData();

      doctorJson.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      // Add medicalSections list items one by one
      for (int i = 0; i < doctor.medicalSections.length; i++) {
        formData.fields
            .add(MapEntry('medicalSections[$i]', doctor.medicalSections[i]));
      }

      // If an image is supplied, it is added to the form.
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

      // Sending the request to create a doctor
      final response = await dio.post(
        '/admin/doctors/create',
        data: formData,
        options: await _generateOptions(),
      );

      return "success";
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return null;
  }

  // How to delete a doctor
  Future<String?> deleteDoctor(String matricule) async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      // Sending the doctor's deletion request
      final response = await dio.delete(
        '/admin/doctor/delete/$matricule',
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: 'Failed to delete doctor');
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return null;
  }

  // How to retrieve all diaries
  Future<List<Agenda>?> fetchAllAgendas() async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      final response = await dio.get(
        '/admin/agendas',
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> agendasJson = response.data['agendas'];
        final List<Agenda> agendas =
            agendasJson.map((json) => Agenda.fromJson(json)).toList();

        return agendas;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to fetch agendas',
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return null;
  }

  // Method for retrieving stays by doctor's registration number
  Future<Map<String, List<Stay>>?> fetchStaysByDoctorMatricule(
      String matricule) async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      final response = await dio.get(
        '/admin/stay-not-programed',
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> staysJson = response.data['stays'];
        final List<Stay> stays =
            staysJson.map((json) => Stay.fromJson(json)).toList();

        // Initialize lists for stays
        List<Stay> stayOfHisDoc = [];
        List<Stay> stayOfOtherDoc = [];

        // Iterate through stays and separate them based on doctorId
        for (var stay in stays) {
          if (stay.doctorId == matricule) {
            stayOfHisDoc.add(stay);
          } else {
            stayOfOtherDoc.add(stay);
          }
        }

        return {
          'stayOfHisDoc': stayOfHisDoc,
          'stayOfOtherDoc': stayOfOtherDoc,
        };
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to fetch stays',
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return null;
  }

  // Method to retrieve the agenda by doctor's number
  Future<Agenda?> fetchAgendaByDoctorMatricule(String matricule) async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      final response = await dio.get(
        '/admin/doctor-agenda',
        queryParameters: {'matricule': matricule},
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        // Checks if the answer is null

        final dynamic responseData = response.data;

        if (responseData != null) {
          // Extract agenda and doctor data from response
          final agendaJson = responseData['agenda'];

          // Create Agenda object
          final Agenda agenda = Agenda.fromJson(agendaJson);
          return agenda;
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to fetch agenda',
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return null;
    }
    return null;
  }

  Future<String?> createAppointment(Appointment appointment) async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      // Data construction for the request
      final Map<String, dynamic> appointmentJson = appointment.toJson();

      // Sending the request to create an appointment
      final response = await dio.post(
        '/admin/create-appointment',
        data: appointmentJson,
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to create appointment',
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return null;
  }

  // Function to retrieve future appointments
  Future<List<Appointment>> fetchAppointmentsStartingToday() async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      final response = await dio.get(
        '/admin/get-appointments-starting-today',
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> appointmentsJson = response.data['appointments'];
        final List<Appointment> appointments =
            appointmentsJson.map((json) => Appointment.fromJson(json)).toList();
        return appointments;
      } else {
        throw Exception('Failed to fetch appointments starting today');
      }
    } catch (e) {
      throw Exception('Failed to fetch appointments starting today: $e');
    }
  }

  Future<List<Appointment>> fetchAppointmentsForDoctorStartingToday(
      String doctorMatricule) async {
    dio.options.baseUrl = AppConfig.baseUrl;

    try {
      final response = await dio.get(
        '/admin/get-appointments-to-doc-starting-today',
        queryParameters: {'doctor_matricule': doctorMatricule},
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> appointmentsJson = response.data['appointments'];
        final List<Appointment> appointments =
            appointmentsJson.map((json) => Appointment.fromJson(json)).toList();
        return appointments;
      } else {
        throw Exception('Failed to fetch appointments starting today');
      }
    } catch (e) {
      throw Exception('Failed to fetch appointments starting today: $e');
    }
  }

  // How to display an error dialog box
  void _handleDioError(DioException e) {
    if (kDebugMode) {
      print("Exception when calling backend log: $e\n");
    }

    // Displaying Dio error messages to the user
    if (e.response?.data != null) {
      var errorMessage = e.response?.data['message'];
      if (kDebugMode) {
        print("errorMessage: $errorMessage");
      }
      showErrorDialog(
          errorMessage, GlobalKey<NavigatorState>().currentState!.context);
    } else {
      showErrorDialog(
          "Erreur réseau", GlobalKey<NavigatorState>().currentState!.context);
    }
  }
}

// How to display an error dialog box
void showErrorDialog(String errorMessage, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Erreur'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
