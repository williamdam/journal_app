//////////////////////////////////////////////////////////////////////
// Author: William Dam
// Date: 03-01-2021
// Description: Data model holds list of form data submissions
//////////////////////////////////////////////////////////////////////
import 'form_data_dto.dart';

class Journal {
  
  // List holds FormData objects
  List<FormData> entries;

  // Constructor takes list of FormData Objects
  Journal({List<FormData> entries = const <FormData>[]}) : this.entries = entries;

  // Placeholder data for development
  List<Map> fakeData =  [
    {'title': 'Journal Entry 1', 'subtitle': 'Subtitle text here 1'},
    {'title': 'Journal Entry 2', 'subtitle': 'Subtitle text here 2'},
    {'title': 'Journal Entry 3', 'subtitle': 'Subtitle text here 3'},
  ];
  
  // Returns list of placeholder data
  List<Map> getFakeData() {
    return fakeData;
  }
  
}