import 'dart:html';

import 'package:dentist_dashboard/services/remote_services.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Future<String?> authUser(LoginData data) {
    return RemoteServices.login(data.name, data.password).timeout(Duration(seconds: 15)).then((String? token) {
      if (token == null) return 'wrong credentials'.tr;
      window.localStorage["token"] = token;
      return null;
    });
  }
}
