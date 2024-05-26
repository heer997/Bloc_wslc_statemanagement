import "dart:convert";
import "package:http/http.dart" as http;

class ApiHelper {
  Future<dynamic> getAPI({required String url}) async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var mData = jsonDecode(response.body);
      return mData;
    } else {
      return null;
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
}
