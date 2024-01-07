import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsomenenyo/helpers/index.dart';
import 'package:tsomenenyo/screens/index.dart';

Route<dynamic>? route(RouteSettings settings) {
  return GetPageRoute(
    settings: settings,
    page: () {
      switch (settings.name) {
        case './':
          return const SplashScreen();
        case '/onboard':
          return const OnboradingScreen();

        case '/login':
          return const LoginScreen();

        case '/notif':
          return const NotificationScreen();

        case '/home':
          return const HomeScreen();

        default:
          return const Error404Screen();
      }
    },
    transition: transition(settings),
  );
}

Transition? transition(RouteSettings settings) {
  switch (settings.name) {
    case './':
      return Transition.leftToRightWithFade;
    case '/login':
    case '/notif':
      return Transition.rightToLeftWithFade;
    default:
      return Transition.downToUp;
  }
}
