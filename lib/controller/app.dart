import 'package:flutter/material.dart';
import '../view/homepage.dart';
import '../view/add_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    initDarkMode();
  }

  void initDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState( () {
      darkMode = prefs.getBool('darkMode') ?? false;
    });
    print('Dark mode at App init: $darkMode');
  }

  @override
  Widget build(BuildContext context) {
    if (darkMode == true) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
        ),
        routes: routes,
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
        ),
        routes: routes,
      );
    }
    
  }
}