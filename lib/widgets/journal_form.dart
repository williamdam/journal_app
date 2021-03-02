import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../model/form_data_dto.dart';

class JournalForm extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final formData = FormData();

  String getDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.yMMMMd('en_US');
    final String formatted = formatter.format(now);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
            autofocus: true, 
            decoration: InputDecoration(
              labelText: 'Title', 
              border: OutlineInputBorder()),
            onSaved: (value) {
              formData.title = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a title';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            autofocus: true, 
            decoration: InputDecoration(
              labelText: 'Body', 
              border: OutlineInputBorder()),
            onSaved: (value) {
              formData.body = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the details.';
              } else {
                return null;
              }
            }
          ),
          SizedBox(height: 10),
          TextFormField(
            autofocus: true, 
            decoration: InputDecoration(
              labelText: 'Rating', 
              border: OutlineInputBorder()),
            onSaved: (value) {
              formData.rating = int.parse(value);
              formData.date = getDate();
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a number 1-5.';
              } else {
                return null;
              }
            }
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Colors.grey,
                child: Text('Cancel'),
                onPressed: () { Navigator.of(context).pop(); },
                
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Save'),
                onPressed: () async {

                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();

                    // REMOVE BEFORE DEPLOYMENT!!!
                    //await deleteDatabase('journal.db');

                    final Database database = await openDatabase(
                      'journal.db', version: 1, onCreate: (Database db, int version) async {
                        await db.execute(
                          'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, date TEXT, rating INT)'
                        );
                      }
                    );
                    await database.transaction( (txn) async {
                      await txn.rawInsert('INSERT INTO journal_entries(title, body, date, rating) VALUES(?, ?, ?, ?)',
                      [formData.title, formData.body, formData.date, formData.rating]);
                    });

                    // Database will close automatically when app quits
                    //await database.close();
                    Navigator.of(context).pop(context);
                  }
                  
                },
                
              )
            ],
          ),
          ],
        )
      ),
    );
  }

  
}