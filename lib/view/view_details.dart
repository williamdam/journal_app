import 'package:flutter/material.dart';

class ViewDetails extends StatelessWidget {

  const ViewDetails({Key key, this.date, this.title, this.body}) : super(key: key);
  final String date;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(date),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
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
          ),
        ),
      ),
    );
  }
}