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

  static Future getComments(int eventResourceId) async {

    Map<String, String> parameters = {
      'eventResourceId': eventResourceId.toString()
    };

    dynamic response = await HttpService.api('GetComments', parameters);
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

  static Future likeItem(String eventResourceId, bool isLike) async {

    Map<String, String> parameters = {
      'userId': AccountService.userId.toString(),
      'eventResourceId': eventResourceId,
      'like': isLike ? "1" : "0"
    };

    dynamic response = await HttpService.api('LikeNewsItem', parameters);
    return response;
  }

  static Future addMessage(int eventId, String message) async {

    Map<String, String> parameters = {
      'userId': AccountService.userId.toString(),
      'eventId': eventId.toString(),
      'message': message
    };

    dynamic response = await HttpService.api('AddMessage', parameters);
    return response;
  }

  static Future addComment(int eventResourceId, String comment) async {

    Map<String, String> parameters = {
      'userId': AccountService.userId.toString(),
      'eventResourceId': eventResourceId.toString(),
      'comment': comment
    };

    dynamic response = await HttpService.api('AddComment', parameters);
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





