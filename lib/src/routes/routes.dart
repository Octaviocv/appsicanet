import 'package:appsicanet/src/pages/home_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    'home': (BuildContext context) => HomePage(),
  };
}
