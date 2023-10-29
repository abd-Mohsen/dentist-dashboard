import 'dart:async';
import 'package:universal_html/html.dart' as html;
import 'dart:js' as js;

import 'package:dentist_dashboard/services/remote_services.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Future<String?>? login(LoginData data) {
    try {
      return RemoteServices.login(data.name, data.password).timeout(const Duration(seconds: 15)).then((String? token) {
        if (token == null) return 'wrong credentials'.tr;
        html.window.localStorage["token"] = token;
        return null;
      });
    } on TimeoutException {
      js.context.callMethod('alert', ['request timed out']);
    } catch (e) {
      //
    }
    return null;
  }

  Future<String?>? signup(SignupData data) {
    try {
      return RemoteServices.register(
        data.name!,
        data.password!,
        data.password!,
        data.additionalSignupData!["username"]!,
        data.additionalSignupData!["phone"]!,
        data.additionalSignupData!["secret"]!,
      ).timeout(const Duration(seconds: 15)).then((String? token) {
        if (token == null) return 'invalid input'.tr;
        html.window.localStorage["token"] = token;
        return null;
      });
    } on TimeoutException {
      js.context.callMethod('alert', ['request timed out']);
    } catch (e) {
      //
    }
    return null;
  }
}
