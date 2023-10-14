import 'dart:convert';
import 'dart:io';

import 'package:autostore/Utility/app/AppUrl.dart';

import 'BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApi {
  @override
  Future getPostApiServies(String url, data) async {
    try {
      await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=${AppUrl.apiKey}'
      });
    } on SocketException {
      throw Exception('Networkk Error');
    }
  }
}
