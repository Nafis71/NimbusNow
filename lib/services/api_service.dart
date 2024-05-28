import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nimbus_now/utils/text_constants.dart';

class ApiService{
  Future<Map<String, dynamic>> fetchWeatherData(String location) async {
    Response response =  await http.get(Uri.parse("${apiBaseUrl}key=$apiKey&q=$location&aqi=no  "));
    if(response.statusCode == 200){
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData;
    }
    throw Exception("Error Occurred : Response Code - ${response.statusCode}");
  }
}