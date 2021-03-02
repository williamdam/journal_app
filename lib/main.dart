import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controller/app.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  runApp(App());
}