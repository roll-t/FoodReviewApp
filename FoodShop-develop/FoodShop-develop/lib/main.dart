import 'package:find_food/app_config.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  await appConfig();
  runApp(const App());
}
