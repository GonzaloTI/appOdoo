import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../models/userodoo.dart';

///     login
Future<ApiResponse> login(String email, String password, String token) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(loginURLOdoo), headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      'ci': email,
      'keynotificaciones': token
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Userodoo.fromJson(jsonDecode(response.body));
        print('Respuesta recibida: ${response.body}');
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

// get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

// get user id
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}

// Get base64 encoded image
String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}
