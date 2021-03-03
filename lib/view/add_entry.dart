import 'package:flutter/material.dart';
import '../widgets/journal_form.dart';

class AddEntry extends StatefulWidget {

  static final routeName = 'new_entry';

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Entry'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: JournalForm(),
          ),
        ),
      ),
    );
  }
}