import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/screen_mange.dart';
import 'package:newlearn_fe_web/constants/page_transistion.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return PageTransition(widget: const MainHomePage());
      case '/result':
        return PageTransition(widget: MainResultPage());
      default:
        return PageTransition(widget: const MainHomePage());
    }
  }
}
