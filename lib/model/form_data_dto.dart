
class FormData {

  FormData({this.title, this.body, this.date, this.rating});
  
  String title;
  String body;
  String date;
  int rating;

  String toString() {
    return 'Title: $title, Body: $body, Time: $date, Rating: $rating';
  }

}