import 'package:dentist_dashboard/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Navigator localNavigator() => Navigator(
      key: NavigationController().navigationKey,
      initialRoute: kHomeViewRoute,
    );
