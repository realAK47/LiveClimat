import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkingHelper {
  NetworkingHelper(@required this.url);
  final String url;
  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var deCode = jsonDecode(data);
      return deCode;
    } else {
      print(response.statusCode);
    }
  }
}
