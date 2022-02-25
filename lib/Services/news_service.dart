import 'dart:io';

import 'account_service.dart';
import 'http_service.dart';

class NewsService {

  static Future getItems() async {

    Map<String, String> parameters = {
      'userId': AccountService.userId.toString()
    };

    dynamic response = await HttpService.api('GetNewsItems', parameters);
    return response;
  }

}



