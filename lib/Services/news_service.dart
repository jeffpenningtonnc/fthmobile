import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fthmobile/Util/globals.dart';
import 'package:http/http.dart' as http;
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

  static Future deleteItem(String eventResourceId) async {

    Map<String, String> parameters = {
      'userId': AccountService.userId.toString(),
      'eventResourceId': eventResourceId,
    };

    dynamic response = await HttpService.api('DeleteNewsItem', parameters);
    return response;
  }

  static Future uploadFile(File file, int eventId, String message, Function(bool) onUploadProgress) async
  {
    var postUri = Uri.parse("https://admin.feedthehungerapp.com/api/mobile/Upload.php");
    var request = http.MultipartRequest("POST", postUri);

    http.MultipartFile multipartFile = await http.MultipartFile.fromPath('file', file.path);

    request.fields['userId'] = AccountService.userId.toString();
    request.fields['eventId'] = eventId.toString();
    request.fields['message'] = message.toString();
    request.files.add(multipartFile);

    request.send().then((response) {
      if (response.statusCode == 200) {
        onUploadProgress(true);
      }
      else {
        onUploadProgress(false);
      }
    });

  }
}





