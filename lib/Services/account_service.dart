import 'package:flutter/cupertino.dart';

import 'http_service.dart';
import 'preference_service.dart';

class AccountService {

  static int userId = 0;
  static String userEmail = "";
  static String firstName = "";
  static String lastName = "";

  static String getInitials()
  {
    if (firstName.isNotEmpty && lastName.isNotEmpty)
    {
      return firstName.substring(0, 1) + lastName.substring(0, 1);
    }

    return "??";
  }

  static String getFullName()
  {
    if (firstName.isNotEmpty && lastName.isNotEmpty)
    {
      return firstName + " " + lastName;
    }

    return "Unknown";
  }

  static Future<bool> authenticate(String email, String pass) async {

    email = email.trim();

    Map<String, String> parameters = {
      'email': email,
      'password': pass
    };

    dynamic response = await HttpService.api('Authenticate', parameters);

    if (response == null || response['statusCode'] == -1) {
      return false;
    }

    userId = int.parse(response['results']['userId'].toString());
    userEmail = response['results']['email'].toString();
    firstName = response['results']['firstName'].toString();
    lastName = response['results']['lastName'].toString();

    return true;
  }

  static void logOut() {
    userId = 0;
    userEmail = "";
    firstName = "";
    lastName = "";

    PreferenceService.setPrefAsString("email", "");
    PreferenceService.setPrefAsString("password", "");
  }

  static Future<int> forgotPasswordUsingOTP(String email) async {

    email = email.trim();

    Map<String, String> parameters = {
      'email': email
    };

    dynamic response = await HttpService.api('ForgotPasswordUsingOTP', parameters);

    if (response == null) {
      return -2;
    }

    return response['statusCode'];
  }

  static Future<int> validateOTP(String email, String otp) async {

    email = email.trim();
    otp = otp.trim();

    Map<String, String> parameters = {
      'email': email,
      'otp': otp
    };

    dynamic response = await HttpService.api('ValidateOTP', parameters);

    if (response == null) {
      return -2;
    }

    return response['statusCode'];
  }

  static Future<bool> updateAccount(String otp, String firstName,
      String lastName, String address, String city, String state, String zip,
      String mobile) async {

    firstName = firstName.trim();
    lastName = lastName.trim();
    address = address.trim();
    city = city.trim();
    state = state.trim();
    zip = zip.trim();
    mobile = mobile.trim();

    Map<String, String> parameters = {
      'otp': otp,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
      'mobile': mobile
    };

    dynamic response = await HttpService.api('UpdateAccount', parameters);

    if (response == null) {
      return false;
    }

    return response['statusCode'] == 0;
  }

  static Future<bool> changePassword(String email, String otp, String password) async {

    email = email.trim();
    otp = otp.trim();
    password = password.trim();

    Map<String, String> parameters = {
      'email': email,
      'otp': otp,
      'password': password
    };

    dynamic response = await HttpService.api('ChangePassword', parameters);

    if (response == null) {
      return false;
    }

    return response['statusCode'] == 0;
  }

  static Future<int> registerUsingOTP(String email) async {
    email = email.trim();

    Map<String, String> parameters = {
      'email': email
    };

    dynamic response = await HttpService.api('RegisterUsingOTP', parameters);

    if (response == null) {
      return -2;
    }

    return response['statusCode'];
  }

}



