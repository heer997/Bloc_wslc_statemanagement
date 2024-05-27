import "dart:convert";
import "dart:io";
import "package:bloc_wslc_statemanagement/Api_handling_using_Bloc/app_exceptions.dart";
import "package:http/http.dart" as http;

class ApiHelper {
  Future<dynamic> getAPI({required String url}) async {
    var uri = Uri.parse(url);

    try {
      var response = await http.get(uri);
      return returnJsonResponse(response);
    } on SocketException catch (e) {
      throw (FetchDataException(errorMsg: "No Internet!!"));
    }
  }

  Future<dynamic> postAPI(
      {required String url, Map<String, dynamic>? bodyParams}) async {
    var uri = Uri.parse(url);
    var response = await http.post(uri, body: bodyParams ?? {});

    if (response.statusCode == 200) {
      var mData = jsonDecode(response.body);
    }
  }

  dynamic returnJsonResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var mData = jsonDecode(response.body);
          return mData;
        }
      case 400:
        throw BadRequestException(errorMsg: response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(errorMsg: response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            errorMsg:
                "Error occurred while Communication with Server with StatusCode : ${response.statusCode}");
    }

    if (response.statusCode == 200) {
      var mData = jsonDecode(response.body);
      return mData;
    } else {
      return null;
    }
  }
}
