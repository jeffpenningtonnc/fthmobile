import 'http_service.dart';

class PromotionsService {

  static Future getPromotions() async {

    Map<String, String> parameters = {};

    dynamic response = await HttpService.api('GetPromotions', parameters);

    return response;
  }

}



