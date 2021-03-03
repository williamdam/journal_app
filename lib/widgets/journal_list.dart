import 'package:flutter/material.dart';
import '../model/form_data_dto.dart';
import '../view/view_details.dart';

class JournalList extends StatefulWidget {

  JournalList({Key key, this.journalItems}) : super(key: key);
  final List<FormData> journalItems;

  @override
  _JournalListState createState() => _JournalListState();
}

class _JournalListState extends State<JournalList> {

  @override
  Widget build(BuildContext context) {
    if (widget.journalItems == null) {
      return Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
          ],
        ),
      );
    } 
    else if (widget.journalItems.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, size: 80,),
            Text('Welcome to your journal'),
          ],
        ),
      );
    }
    else {
      return ListView.builder(
      itemCount: widget.journalItems.length,
      itemBuilder: (context, i) {
        return ListTile(
          onTap: () { 
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => ViewDetails(
                  title: widget.journalItems[i].title, 
                  body: widget.journalItems[i].body, 
                  date: widget.journalItems[i].date,
                )
              )
            ); 
          },
          title: Text('${widget.journalItems[i].title}'),
          subtitle: Text('${widget.journalItems[i].date}'),
        );
      },
    );
    }
    
  }
}