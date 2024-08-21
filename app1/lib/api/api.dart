import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String _baseUrl = 'https://events.dotcom.tn/events';
static Future<Map<String, dynamic>> loginUser({
  required String email,
  required String password,
}) async {
  final String loginEndpoint = '$_baseUrl/login';

  final Map<String, dynamic> body = {
    'Credentials': {
      'Login': email,
      'Password': password,
    },
  };

  try {
    final response = await http.post(
      Uri.parse(loginEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {
        'error': true,
        'message': 'Failed to login. Server responded with status code ${response.statusCode}.',
      };
    }
  } catch (e) {
    return {
      'error': true,
      'message': 'An error occurred: $e',
    };
  }
}


  static Future<Map<String, dynamic>> registerUser({
    required String email,
    required String password,
  }) async {
    final String registerEndpoint = '$_baseUrl/register';

    final Map<String, dynamic> body = {
      'Credentials': {
        'Login': email,
        'Password': password,
      },
    };

    try {
      final response = await http.post(
        Uri.parse(registerEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'error': true,
          'message': 'Failed to register. Server responded with status code ${response.statusCode}.',
        };
      }
    } catch (e) {
      return {
        'error': true,
        'message': 'An error occurred: $e',
      };
    }
  }
}

