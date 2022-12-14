import 'package:couple_planet/core/auth_check.dart';
import 'package:couple_planet/core/fade_transition.dart';
import 'package:couple_planet/core/route_constants.dart';
import 'package:couple_planet/ui/views/home_screen/home_screen_view.dart';
import 'package:couple_planet/ui/views/sign_in_screen/sign_in_screen_view.dart';
import 'package:couple_planet/ui/views/sign_up_screen/sign_up_screen_view.dart';
import 'package:couple_planet/ui/views/splash_screen/splash_screen_view.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {

      //Basic Pages
      case authCheck:
        return FadeRoute(page: const AuthCheck());

      case splashScreen:
        return FadeRoute(page: const SplashScreenView());

      case signInScreen:
        return FadeRoute(page: const SignInScreenView());

      case signUpScreen:
        return FadeRoute(page: const SignUpScreenView());

      case homeScreen:
        return FadeRoute(page: const HomeScreenView());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('ERROR ROUTE'),
        ),
      );
    });
  }
}
