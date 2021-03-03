//////////////////////////////////////////////////////////////////////
// Author: William Dam
// Date: 03-01-2021
// Description: Data model holds form data for each entry
//////////////////////////////////////////////////////////////////////
class FormData {

  // Constructor takes args for object
  FormData({this.title, this.body, this.date, this.rating});
  
  String title;
  String body;
  String date;
  int rating;

  // Returns string of vars
  String toString() {
    return 'Title: $title, Body: $body, Time: $date, Rating: $rating';
  }

}