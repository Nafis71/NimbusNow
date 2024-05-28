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
      "parameterName"  : "Visibility",
      "value" : "79%" ,
      "icon" : Icons.visibility,
    },
    {
      "parameterName"  : "Humidity",
      "value" : "80%" ,
      "icon" : Icons.water_drop_outlined,
    },
    {
      "parameterName"  : "UV Index",
      "value" : "1/10" ,
      "icon" : Icons.sunny,
    },
    {
      "parameterName"  : "Cloud",
      "value" : "23%" ,
      "icon" : Icons.cloud,
    }
  ];

  Future<void> getWeatherData() async{
    try{
      Map<String,dynamic> jsonData = await _apiService.fetchWeatherData("Dhaka");
      weatherModel = WeatherModel.fromJson(jsonData);
      currentCondition = weatherModel.current?.condition?.text?.toLowerCase() ?? "sunny";
      extraWeatherData[0]["value"] = "${weatherModel.current?.feelslikeC.toString()}°";
      extraWeatherData[1]["value"] = "${weatherModel.current?.windKph.toString()} km/h";
      extraWeatherData[2]["value"] = "${weatherModel.current?.visKm.toString()} km";
      extraWeatherData[3]["value"] = "${weatherModel.current?.humidity.toString()}%";
      extraWeatherData[4]["value"] = "${weatherModel.current?.uv?.toInt().toString()}/10";
      extraWeatherData[5]["value"] = "${weatherModel.current?.cloud.toString()}%";
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