import '/Services/http_service.dart';

class EventService {

  static Future getSubscribedOrganizations(int userId) async {

    Map<String, String> parameters = {
      'userId': userId.toString()
    };

    dynamic response = await HttpService.api('GetSubscribedOrganizations', parameters);

    return response;
  }

  static Future findLiveEvents(String searchText, bool nearMe, int userId) async {

    Map<String, String> parameters = {
      'searchText': searchText,
      'nearMe': nearMe ? "1" : "0",
      'userId': userId.toString()
    };

    dynamic response = await HttpService.api('FindLiveEvents', parameters);

    return response;
  }

  static Future subscribeToOrganization(int organizationId, bool subscribe) async {

    int doSubscribe = subscribe ? 1 : 0;

    Map<String, String> parameters = {
      'organizationId': organizationId.toString(),
      'subscribe': doSubscribe.toString()
    };

    dynamic response = await HttpService.api('SubscribeToOrganization', parameters);

    return response;
  }

}



