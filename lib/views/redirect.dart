import 'package:universal_html/html.dart';

import 'package:dentist_dashboard/layout.dart';
import 'package:dentist_dashboard/views/login_view.dart';
import 'package:flutter/material.dart';

class RedirectPage extends StatelessWidget {
  const RedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Redirect to the dashboard page or any other default page
    // based on your authentication status or other logic
    final isAuthenticated = window.localStorage["token"] != null;
    //return isAuthenticated ? Layout() : LoginView();
    return Layout();
  }
}
