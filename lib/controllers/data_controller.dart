import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nimbus_now/models/weather_model.dart';
import 'package:nimbus_now/services/api_service.dart';

class DataController extends ChangeNotifier{
  final ApiService _apiService = ApiService();
  WeatherModel weatherModel = WeatherModel();
  String? currentCondition = "sunny";
  List<Map<String,dynamic>> extraWeatherData = [
    {
     "parameterName"  : "Feel like",
     "value" : "16°" ,
      "icon" : Icons.thermostat,
    },
    {
      "parameterName"  : "Wind",
      "value" : "20 km/h" ,
      "icon" : Icons.air,
    },
    {
      "parameterName"  : "Precipitation",
      "value" : "79%" ,
      "icon" : Icons.umbrella,
    },
    {
      "parameterName"  : "Humidity",
      "value" : "80%" ,
      "icon" : Icons.thermostat,
    },
    {
      "parameterName"  : "UV Index",
      "value" : "1/10" ,
      "icon" : Icons.sunny,
    },
    {
      "parameterName"  : "Cloud",
      "value" : "Mostly Cloudy" ,
      "icon" : Icons.thermostat,
    }
  ];

  Future<void> getWeatherData() async{
    try{
      Map<String,dynamic> jsonData = await _apiService.fetchWeatherData("Dhaka");
      weatherModel = WeatherModel.fromJson(jsonData);
      currentCondition = weatherModel.current?.condition?.text?.toLowerCase() ?? "sunny";
      notifyListeners();
    }catch(e){
      if(kDebugMode){
        debugPrint(e.toString());
      }
    }
  }

  String getDateTime(){
    return DateFormat.MMMMEEEEd().format(DateTime.now());
  }

}