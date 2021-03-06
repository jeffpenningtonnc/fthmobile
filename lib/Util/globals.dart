import 'package:flutter/material.dart';

const String apiKey = "7g84VnefBmzR7QjN";

const String serverDomain = "https://admin.feedthehungerapp.com";
const String mobileApi = serverDomain + "/api/mobile/";
const String resourcePath = serverDomain + "/api/uploads/";
const String donationUrl = "https://www.feedthehungerapp.com/donate.html";

const String donationHtml = """
<p>You have a hunger in your heart to make a difference in peoples’ lives, to make
 a difference for eternity. You can impact the lives of the hungry here in 
 America and around the world. </p>
 
 <p>All gifts made to Feed the Hunger are 
 tax-deductible to the full extent allowed by law. Feed the Hunger is a member 
 of the Evangelical Council for Financial Accountability.</p>
""";

const String backgroundLocation = "images/background.png";
const String logoLocation = "images/logo.png";

class Globals {

  static Color getPrimaryColor() {
    return const Color.fromARGB(255, 142, 197, 95);
  }

  static Color getSecondaryColor() {
    return const Color.fromARGB(255, 0, 0, 0);
  }

  static String getAPIKey() {
    return apiKey;
  }

  static String getAPIPath() {
    return mobileApi;
  }

  static String getResource(String resourceName, int version) {
    return resourcePath + "/" + resourceName + "_" + version.toString();
  }

  static String getDonationsUrl() {
    return donationUrl;
  }

  static String getDonationContent() {
    return donationHtml;
  }

}
