import 'http_service.dart';

class LibraryService {

  static Future getItems(int type) async {

    Map<String, String> parameters = {
      'type': type.toString()
    };

    dynamic response = await HttpService.api('GetLibraryItems', parameters);

    return response;
  }

}



