
import 'form_data_dto.dart';

class Journal {
  
  List<FormData> entries;
  Journal({List<FormData> entries = const <FormData>[]}) : this.entries = entries;

  List<Map> fakeData =  [
    {'title': 'Journal Entry 1', 'subtitle': 'Subtitle text here 1'},
    {'title': 'Journal Entry 2', 'subtitle': 'Subtitle text here 2'},
    {'title': 'Journal Entry 3', 'subtitle': 'Subtitle text here 3'},
  ];
  

  List<Map> getFakeData() {
    return fakeData;
  }
  
}