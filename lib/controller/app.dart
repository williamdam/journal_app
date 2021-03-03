//////////////////////////////////////////////////////////////////////
// Author: William Dam
// Date: 03-01-2021
// Description: App class is the controller for the entire application.
//////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import '../view/homepage.dart';
import '../view/add_entry.dart';

//////////////////////////////////////////////////////////////////////
// Description: App class returns MaterialApp of entire application
//////////////////////////////////////////////////////////////////////
class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  // Navigation routes
  static final routes = {
    HomePage.routeName: (context) => HomePage(),
    AddEntry.routeName: (context) => AddEntry(),
  };

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // MaterialApp holds the entire program
    return MaterialApp(
        title: 'Journal App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
      );
    
  }
}