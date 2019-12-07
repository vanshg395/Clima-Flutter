import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkingHelper {
  String url;

  NetworkingHelper(this.url);

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    return responseData;
  }
}
