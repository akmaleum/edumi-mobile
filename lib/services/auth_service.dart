import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl =
      'http://10.0.2.2:80/blog_api'; // For Android emulator
  // static const String baseUrl = 'http://localhost:80/blog_api'; // For iOS simulator

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sign_in.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          jsonDecode(response.body)['error'] ?? 'Failed to sign in',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<Map<String, dynamic>> signUp({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create_user.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          jsonDecode(response.body)['error'] ?? 'Failed to create account',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<Map<String, dynamic>> getUserDetails(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_user_details.php?id=$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body);
        } catch (_) {
          throw Exception(
            'Unexpected server response. Please try again later.',
          );
        }
      } else {
        try {
          throw Exception(
            jsonDecode(response.body)['error'] ??
                'Failed to fetch user details',
          );
        } catch (_) {
          throw Exception(
            'Failed to fetch user details. Please try again later.',
          );
        }
      }
    } catch (e) {
      throw Exception(
        'Failed to connect to server. Please check your connection and try again.',
      );
    }
  }

  Future<Map<String, dynamic>> updateUserDetails({
    required int id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_user_details.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': id,
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          jsonDecode(response.body)['error'] ?? 'Failed to update user details',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
