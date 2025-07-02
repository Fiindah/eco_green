import 'dart:convert';

import 'package:eco_green/api/endpoint.dart';
import 'package:eco_green/helper/preference.dart';
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:http/http.dart' as http;

class UserService {
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Endpoint.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      final Map<String, dynamic> resBody = jsonDecode(response.body);
      debugPrint("Login API Response: ${response.body}");

      if (response.statusCode == 200) {
        if (resBody["data"] != null && resBody["data"]["token"] != null) {
          await SharePref.saveToken(resBody["data"]["token"]);

          // Save user name and email if available in the response
          if (resBody["data"]["user"] != null) {
            final user = resBody["data"]["user"];
            if (user["name"] != null) {
              await SharePref.saveUserName(user["name"]);
            }
            if (user["email"] != null) {
              await SharePref.saveUserEmail(user["email"]);
            }
          }
          return resBody; // Return the full response body
        } else {
          throw Exception("Token not found in response data.");
        }
      } else {
        // Handle non-200 status codes
        String message =
            resBody["message"] ?? "Login failed. Please try again.";
        if (resBody["errors"] != null) {
          // You can parse specific validation errors here if needed
          message += "\nDetails: ${jsonEncode(resBody["errors"])}";
        }
        throw Exception(message);
      }
    } catch (e) {
      debugPrint("Error during login: $e");
      return {"errors": true, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Endpoint.register),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      final Map<String, dynamic> resBody = jsonDecode(response.body);
      debugPrint("Register API Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return resBody;
      } else {
        String message =
            resBody["message"] ?? "Registration failed. Please try again.";
        if (resBody["errors"] != null) {
          message += "\nDetails: ${jsonEncode(resBody["errors"])}";
        }
        throw Exception(message);
      }
    } catch (e) {
      debugPrint("Error during registration: $e");
      return {"errors": true, "message": e.toString()};
    }
  }
}

// import 'package:eco_green/api/endpoint.dart';
// import 'package:eco_green/models/login_error_response.dart';
// import 'package:eco_green/models/login_response.dart';
// import 'package:eco_green/models/register_error_respone.dart';
// import 'package:eco_green/models/register_response.dart';
// import 'package:http/http.dart' as http;

// class UserService {
//   Future<Map<String, dynamic>> registerUser({
//     required String email,
//     required String name,
//     required String password,
//   }) async {
//     final response = await http.post(
//       Uri.parse(Endpoint.register),
//       headers: {"Accept": "application/json"},
//       body: {"name": name, "email": email, "password": password},
//     );
//     print(response.body);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print(registerResponseFromJson(response.body).toJson());
//       return registerResponseFromJson(response.body).toJson();
//     } else if (response.statusCode == 422) {
//       return registerErrorResponseFromJson(response.body).toJson();
//     } else {
//       print("Failed to register user: ${response.statusCode}");
//       throw Exception("Failed to register user: ${response.statusCode}");
//     }
//   }

//   Future<Map<String, dynamic>> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     final response = await http.post(
//       Uri.parse(Endpoint.login),
//       headers: {"Accept": "application/json"},
//       body: {"email": email, "password": password},
//     );
//     print(response.body);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print(loginResponseFromJson(response.body).toJson());
//       return loginResponseFromJson(response.body).toJson();
//     } else if (response.statusCode == 422) {
//       return loginErrorResponseFromJson(response.body).toJson();
//     } else {
//       print("Failed to login user: ${response.statusCode}");
//       throw Exception("Failed to login user: ${response.statusCode}");
//     }
//   }
// }
