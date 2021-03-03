import 'package:flutter/material.dart';

class JournalDetails extends StatelessWidget {

  const JournalDetails({Key key, this.date, this.title, this.body}) : super(key: key);
  final String date;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: Text(body, style: TextStyle(fontSize: 16))),
          ],
        ),
      ],
    );
  }
}