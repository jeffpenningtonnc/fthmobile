import 'package:fthmobile/Services/account_service.dart';

import 'http_service.dart';

class LibraryService {

  static Future getItems(int type) async {

    Map<String, String> parameters = {
      'type': type.toString()
    };

    dynamic response = await HttpService.api('GetLibraryItems', parameters);
    return response;
  }

  static Future getSubscriptions() async {

    Map<String, String> parameters = {
      'userId': AccountService.userId.toString(),
    };

    dynamic response = await HttpService.api('GetLibrarySubscriptions', parameters);
    return response;
  }

  static Future subscribe(String resourceID) async {

    Map<String, String> parameters = {
      'userId': AccountService.userId.toString(),
      'resourceId': resourceID,
      'subscribe' : "1"
    };

    dynamic response = await HttpService.api('SubscribeToResource', parameters);
    return response;
  }

  static Future unsubscribe(String resourceID) async {

    Map<String, String> parameters = {
      'userId': AccountService.userId.toString(),
      'resourceId': resourceID,
      'subscribe' : "0"
    };

    dynamic response = await HttpService.api('SubscribeToResource', parameters);
    return response;
  }

  static Future getDevotionals() async {

    Map<String, String> parameters = {
      'userId': AccountService.userId.toString()
    };

    dynamic response = await HttpService.api('GetLibraryDevotionals', parameters);
    return response;
  }

  static Future getDevotional(int resourceId, int day) async {

    Map<String, String> parameters = {
      'resourceId': resourceId.toString(),
      'day': day.toString()
    };

    dynamic response = await HttpService.api('GetLibraryDevotional', parameters);
    return response;
  }

}



