import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postownik/data/exceptions/exceptions.dart';

abstract class MyHttpClientInterface{
  Future<dynamic> get(String url, {Map<String, String>? querryParemeter});
}


class MyHttpClient implements MyHttpClientInterface{
  final http.Client client;
  MyHttpClient({required this.client});

  Future<dynamic> get(String url, {Map<String, String>? querryParemeter}) async {

    debugPrint('Request: $url');
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
      },
    );
    debugPrint('Response: ${response.body}');
    if (response.statusCode != 200) {
      debugPrint(response.statusCode.toString());
      debugPrint("RESPONSE: ${response.body.toString()}");
      throw ServerException(response.body.toString());
    } else {
      final responseBody = json.decode(response.body);
      debugPrint('reponse body : $responseBody');
      return responseBody;
    }
  }
}