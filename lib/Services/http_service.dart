import 'account_service.dart';
import '../Util/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static dynamic api(String method, Map<String, String> parameters) async {

    parameters.addAll({
      'apiKey': Globals.getAPIKey(),
      'userId': AccountService.userId.toString()
    });

    String jsonParameters = json.encode(parameters);

    http.Response response = await http.post(
        Uri.parse(Globals.getAPIPath() + method + ".php"), body: jsonParameters, headers: headers);

    if (response.statusCode != 200) {
      return null;
    }

    return json.decode(response.body);
  }

}