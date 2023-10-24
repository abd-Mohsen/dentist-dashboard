import 'package:dentist_dashboard/controllers/login_controller.dart';
import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    LoginController lC = Get.put(LoginController());

    Widget login() => FlutterLogin(
          title: 'Welcome Admin',
          onLogin: lC.login,
          //onSignup: _signupUser,
          hideForgotPasswordButton: true,
          onSubmitAnimationCompleted: () {
            Get.offAllNamed('/dashboard');
          },
          onRecoverPassword: (String s) {
            return null;
          },
          theme: LoginTheme(
            primaryColor: cs.primary,
            accentColor: cs.onBackground,
            pageColorDark: cs.background,
            pageColorLight: cs.background,
            cardTheme: CardTheme(
              color: cs.surface,
              margin: const EdgeInsets.all(30),
            ),
          ),
        );

    return Scaffold(
      body: ResponsiveWidget(
        largeWidget: Row(
          children: [
            Expanded(
              child: Material(
                color: cs.primary,
                child: Center(
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Icon(Icons.shopping_cart, size: 150, color: cs.background),
                  //     const SizedBox(height: 20),
                  //     Text(
                  //       "Dashboard",
                  //       style: tt.displayLarge!.copyWith(color: cs.background),
                  //     ),
                  //   ],
                  // ),
                  child: Image.asset(Get.isDarkMode ? "assets/images/logo_black.png" : "assets/images/logo_white.png"),
                ),
              ),
            ),
            Expanded(
              child: login(),
            )
          ],
        ),
        smallWidget: login(),
      ),
    );
  }
}
