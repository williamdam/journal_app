import 'dart:async';
import 'package:flutter/material.dart';
import 'package:journal_app/widgets/journal_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'add_entry.dart';
import '../model/form_data_dto.dart';

class HomePage extends StatefulWidget {

  static final routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<FormData> journalItems;
  bool darkMode = false;

  void initState() {
    super.initState();
    initDarkMode();
    loadDatabase();
  }

  // Experimental
  FutureOr onGoBack(dynamic value) {
    setState(() {
      loadDatabase();
    });
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => AddEntry());
    Navigator.push(context, route).then(onGoBack);
  }
  // Experimental

  void initDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState( () {
      darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void saveDarkMode(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isDark) {
      prefs.setBool('darkMode', true);
    } else {
      prefs.setBool('darkMode', false);
    }
  }

  void loadDatabase() async {
    final Database database = await openDatabase(
      'journal.db', version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, date TEXT, rating INT)');
      }
    );
    // Generate list of map objects, for each row.  
    List<Map> journalRecords = await database.rawQuery('SELECT * FROM journal_entries');

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

  ThemeData _lightTheme = ThemeData(brightness: Brightness.light);
  ThemeData _darkTheme = ThemeData(brightness: Brightness.dark);

  GlobalKey<ScaffoldState> _key = GlobalKey();

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
        body: JournalList(journalItems: journalItems,),
        floatingActionButton: FloatingActionButton(
          //onPressed: () { Navigator.of(context).pushNamed(AddEntry.routeName);},
          onPressed: () { navigateSecondPage(); },
          tooltip: 'Add Entry',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

}