import 'package:flutter/material.dart';
import '../view/homepage.dart';
import '../view/add_entry.dart';

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  Brightness brightness;

  static final routes = {
    HomePage.routeName: (context) => HomePage(),
    AddEntry.routeName: (context) => AddEntry(),
  };

  bool darkMode = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
      );
    
  }
}