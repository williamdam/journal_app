//////////////////////////////////////////////////////////////////////
// Author: William Dam
// Date: 03-01-2021
// Description: Home page shows list of journal entries, or icon
// if no entries have been made.
//////////////////////////////////////////////////////////////////////
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:journal_app/widgets/journal_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'add_entry.dart';
import '../model/form_data_dto.dart';

// Path to database info strings
const DB_SCHEMA_PATH = 'assets/schema.txt';
const DB_SELECT_PATH = 'assets/select.txt';

class HomePage extends StatefulWidget {

  static final routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}


//////////////////////////////////////////////////////////////////////
// Description: Displays list of journal entries, adaptive to device
// orientation. Communicates with SQLite database.
//////////////////////////////////////////////////////////////////////
class _HomePageState extends State<HomePage> {

  // List of FormData objects
  List<FormData> journalItems;

  // Initialize dark mode
  bool darkMode = false;

  void initState() {
    super.initState();
    initDarkMode();
    loadDatabase();
  }

  // Reload database when return from newEntryPage
  FutureOr onGoBack(dynamic value) {
    setState(() {
      loadDatabase();
    });
  }

  // Route to new journal entry page
  void newEntryPage() {
    Route route = MaterialPageRoute(builder: (context) => AddEntry());
    Navigator.push(context, route).then(onGoBack);
  }

  // Set dark mode from shared preferences
  void initDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState( () {
      darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  // Save dark mode to shared preferences
  void saveDarkMode(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isDark) {
      prefs.setBool('darkMode', true);
    } else {
      prefs.setBool('darkMode', false);
    }
  }

  // Load SQLite database
  void loadDatabase() async {
    final Database database = await openDatabase(
      'journal.db', version: 1, onCreate: (Database db, int version) async {
        await db.execute(DB_SCHEMA_PATH);
      }
    );
    // Generate list of map objects, for each row.  
    List<Map> journalRecords = await database.rawQuery(DB_SELECT_PATH);

    // Map the list to list of FormData objects
    List<FormData> journalEntries = journalRecords.map( (record) {
      // Instantiate FormData object for each record
      return FormData(
        title: record['title'],
        body: record['body'],
        date: record['date'],
        rating: record['rating'],
      );
    }).toList();
    setState( () {
      journalItems = journalEntries;
    });
    
  }

  // Define light and dark modes
  ThemeData _lightTheme = ThemeData(brightness: Brightness.light);
  ThemeData _darkTheme = ThemeData(brightness: Brightness.dark);

  // Global key for form
  GlobalKey<ScaffoldState> _key = GlobalKey();

  //////////////////////////////////////////////////////////////////////
  // Description: Show list of entries by date. Adaptive layout 
  // on device rotation.  Drawer widget updates dark mode.
  //////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkMode ? _darkTheme : _lightTheme,
      title: 'Journal App',
      home: Scaffold(
        key: _key,
        endDrawer: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 80,
                child: DrawerHeader(
                  child: Text('Settings', style: TextStyle(fontSize: 20),)
                ),
              ),
              SwitchListTile(
                title: Text('Dark Mode'),
                value: darkMode, 
                onChanged: (state) {
                  setState(() {
                    darkMode = state;
                  });
                  saveDarkMode(state);
                }
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Journal Entries'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ), 
              onPressed: () { _key.currentState.openEndDrawer(); },
            )
          ],
        ),
        body: JournalList(journalItems: journalItems),
        floatingActionButton: FloatingActionButton(
          onPressed: () { newEntryPage(); },
          tooltip: 'Add Entry',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

}