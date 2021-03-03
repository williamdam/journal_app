//////////////////////////////////////////////////////////////////////
// Author: William Dam
// Date: 03-01-2021
// Description: Column widget for details of a single post.
//////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'star_rating.dart';

class JournalDetails extends StatelessWidget {

  const JournalDetails({Key key, this.date, this.title, this.body, this.rating}) : super(key: key);
  final String date;
  final String title;
  final String body;
  final int rating;

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
        Row(
          children: [
            StarDisplay(value: rating)
          ],
        )
      ],
    );
  }
}