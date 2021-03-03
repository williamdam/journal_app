//////////////////////////////////////////////////////////////////////
// Author: William Dam
// Date: 03-01-2021
// Description: Main entry point for application
//////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controller/app.dart';

//////////////////////////////////////////////////////////////////////
// Description: Main function for the program.  Enable landscape and
// portrait orientation.  
//////////////////////////////////////////////////////////////////////
void main() {

  // Enable all 3 orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  // Run the application
  runApp(App());
}