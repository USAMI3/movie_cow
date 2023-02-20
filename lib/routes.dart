import 'package:flutter/material.dart';
import 'package:movie_cow/views/home.dart';

class Routes {
  Routes._();

  static const String home = '/home';

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    home: (BuildContext context) => const HomeView(),
  };
}
