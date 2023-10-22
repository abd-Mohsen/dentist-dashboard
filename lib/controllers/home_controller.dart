import 'dart:async';
import 'dart:js' as js;
import 'package:dentist_dashboard/constants.dart';
import 'package:dentist_dashboard/models/user_model.dart';
import 'package:dentist_dashboard/services/remote_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }

  late UserModel _currentUser;
  UserModel get currentUser => _currentUser;

  bool _loadingProfile = false;
  bool get loadingProfile => _loadingProfile;

  void toggleLoading(bool val) {
    _loadingProfile = val;
    update();
  }

  bool _fetchedProfile = false;
  bool get fetchedProfile => _loadingProfile;

  void toggleFetched(bool val) {
    _fetchedProfile = val;
    update();
  }

  Future<void> getCurrentUser() async {
    try {
      toggleLoading(true);
      _currentUser = (await RemoteServices.fetchCurrentUser().timeout(kTimeOutDuration))!;
      toggleFetched(true);
    } on TimeoutException {
      js.context.callMethod('alert', ['request timed out']);
    } catch (e) {
      print(e.toString());
    } finally {
      toggleLoading(false);
    }
  }
}
