import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkApiService {
  static final baseUrl = "http://appdev.cerebrum.ae/covidapi/quarantine";
  static final register = "/register";
  static final login = "/login";
  static final resendSMSForUser = "/resendsmsforuser";
  static final updateUserSMSVerified = "/updateusersmsverified";

  // Network api request
  static Future<dynamic> networkRequest(
      Map<dynamic, dynamic> bodyData, String apiName) async {
    Map<String, String> header = Map();
    header.putIfAbsent("content-type", () => "application/json");
    var body = json.encode(bodyData);
    String url = baseUrl + apiName;
    try {
      final response = await http
          .post(url, headers: header, body: body)
          .timeout(const Duration(seconds: 30))
          .then((result) {
        if (result.statusCode == 200) {
          print("API Response Success");
          print(result.body);
          Map<String, dynamic> responseMap = jsonDecode(result.body);
          return responseMap;
        } else {
          print("API Response Failed");
          return null;
        }
      }).catchError((onError) {
        print("Something went wrong, for returning response");
        print(onError.toString());
        return onError;
      });
      return response;
    } on TimeoutException catch (e) {
      print("Something went wrong, network time out");
      print(e.toString());
      return e.toString();
    } on Error catch (e) {
      print("Something went wrong, network call not reached");
      print(e.toString());
      return e.toString();
    }
  }

  // Network api request for registering user
  Future<dynamic> registerUser(Map body) async {
    dynamic response = await networkRequest(body, register);
    return response;
  }

  // Network api request for user login
  Future<dynamic> loginUser(Map body) async {
    dynamic response = await networkRequest(body, login);
    return response;
  }

  // Network api request for sending OTP
  Future<dynamic> sendSMSTOUser(Map body) async {
    dynamic response = await networkRequest(body, resendSMSForUser);
    return response;
  }

  // Network api request for updating user SMS/OTP
  Future<dynamic> userUpdateSMSVerified(Map body) async {
    dynamic response = await networkRequest(body, updateUserSMSVerified);
    return response;
  }
}
