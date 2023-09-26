import 'dart:convert';
import 'dart:js' as js;
import 'package:universal_html/html.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class RemoteServices {
  static const String _hostIP = "http://10.0.2.2:8000/api";
  static http.Client client = http.Client();
  static String get token => window.localStorage["token"] ?? "no token ";

  /// auth requests

  static Future<String?> register(
    String email,
    String password,
    String rePassword,
    String name,
    String phone,
    String secret,
  ) async {
    var response = await client.post(
      Uri.parse("$_hostIP/register-admin"),
      body: jsonEncode({
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "secret": secret,
        "password_confirmation": rePassword,
      }),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)["access_token"];
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  //todo: don't let users login to dashboard
  //todo: handle session expiration
  static Future<String?> login(String email, String password) async {
    var response = await client.post(
      Uri.parse("$_hostIP/login"),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)["access_token"];
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> logout() async {
    var response = await client.post(
      Uri.parse("$_hostIP/logout"),
      body: jsonEncode({
        "Authorization": "Bearer $token",
      }),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  /// otp requests

  static Future<String?> sendRegisterOtp() async {
    var response = await client.get(
      Uri.parse("$_hostIP/send-register-otp"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)["url"];
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> verifyRegisterOtp(String otp, String url) async {
    var response = await client.post(
      Uri.parse(url),
      body: jsonEncode({
        'otp': otp,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  static Future<bool> sendForgotPasswordOtp(String email) async {
    var response = await client.post(
      Uri.parse('$_hostIP/send-reset-otp'),
      body: jsonEncode({
        'email': email,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  static Future<String?> verifyForgotPasswordOtp(String email, String otp) async {
    var response = await client.post(
      Uri.parse('$_hostIP/verify-reset-otp'),
      body: jsonEncode({
        'email': email,
        'otp': otp,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)["reset_token"];
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> resetPassword(String email, String password, String rePassword, String resetToken) async {
    var response = await client.post(Uri.parse('$_hostIP/reset-password'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'password_confirmation': rePassword,
          'token': resetToken,
        }),
        headers: {
          'Content-Type': 'application/json',
          "Accept": 'application/json',
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  /// profile requests

  // upload profile pic

  static Future<UserModel?> fetchCurrentUser() async {
    var response = await client.get(
      Uri.parse("$_hostIP/profile"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return null;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> editProfile(String name, String phone) async {
    var response = await client.post(
      Uri.parse('$_hostIP/edit-profile'),
      body: jsonEncode({
        'name': name,
        'phone': phone,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return false;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  static Future<bool> editPassword(String newPassword, String currentPassword) async {
    var response = await client.post(
      Uri.parse('$_hostIP/edit-password'),
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return false;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }
}
