//////////////////////////////////////////////////////////////////////
// Author: William Dam
// Date: 03-01-2021
// Description: Page shows details of single post
//////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import '../widgets/journal_details.dart';

class ViewDetails extends StatelessWidget {

  const ViewDetails({Key key, this.date, this.title, this.body}) : super(key: key);
  final String date;
  final String title;
  final String body;

//////////////////////////////////////////////////////////////////////
// Description: Full page view of journal entry details for one entry
//////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(date),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: JournalDetails(date: date, title: title, body: body)
        ),
      ),
    );
  }
}