//////////////////////////////////////////////////////////////////////
// Author: William Dam
// Date: 03-01-2021
// Description: ListView widget shows all journal entries. OnTap shows
// entry details.
//////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:journal_app/widgets/journal_details.dart';
import '../model/form_data_dto.dart';
import '../view/view_details.dart';

class JournalList extends StatefulWidget {

  JournalList({Key key, this.journalItems}) : super(key: key);
  final List<FormData> journalItems;

  @override
  _JournalListState createState() => _JournalListState();
}

//////////////////////////////////////////////////////////////////////
// Description: Adaptive layout of journal entries
//////////////////////////////////////////////////////////////////////
class _JournalListState extends State<JournalList> {

  //////////////////////////////////////////////////////////////////////
  // Description: Returns widget of one column layout
  //////////////////////////////////////////////////////////////////////
  Widget oneColumnLayout() {
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
                  rating: widget.journalItems[i].rating,
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

  //////////////////////////////////////////////////////////////////////
  // Description: Instantiate object of journal details
  //////////////////////////////////////////////////////////////////////
  Widget details(BuildContext context, i) {
    return JournalDetails(
      date: widget.journalItems[i].date, 
      title: widget.journalItems[i].title, 
      body: widget.journalItems[i].body,
      rating: widget.journalItems[i].rating
    );
  }

  // Default value for right column in twoColumnLayout
  Widget rightSide = Text('Click on a journal entry to see details.');

  //////////////////////////////////////////////////////////////////////
  // Description: Returns widget of two column layout
  //////////////////////////////////////////////////////////////////////
  Widget twoColumnLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.journalItems.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () { 
                  setState(() {
                    rightSide = details(context, i);
                  });
                },
                title: Text('${widget.journalItems[i].title}'),
                subtitle: Text('${widget.journalItems[i].date}'),
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: rightSide,
          ),
        )
      ],
    );

  }

//////////////////////////////////////////////////////////////////////
// Description: Build widget displays one column or two column layout
// based on available space.
//////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    if (widget.journalItems == null || widget.journalItems.length == 0) {
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
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return oneColumnLayout();
          } else {
            return twoColumnLayout(context);
          }
        },
      );
      
    }
    
  }
}