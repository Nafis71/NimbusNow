import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nimbus_now/controllers/astronomy_controller.dart';
import 'package:nimbus_now/controllers/location_controller.dart';
import 'package:nimbus_now/models/forecastModels/Hour.dart';
import 'package:nimbus_now/models/forecastModels/forecastModel.dart';
import 'package:nimbus_now/services/api_service.dart';
import '../models/weatherModels/weather_model.dart';

class DataController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isRefreshing = false;
  WeatherModel weatherModel = WeatherModel();
  late LocationController _locationProvider;
  late AstronomyController _astronomyProvider;
  String? currentCondition = "sunny";
  List<ForecastModel> forecastModel = [];
  List<Hour> hourlyForecastList = [];
  List<Map<String, dynamic>> extraWeatherData = [
    {
      "parameterName": "Feel like",
      "value": "16°",
      "icon": Icons.thermostat,
    },
    {
      "parameterName": "Wind",
      "value": "20 km/h",
      "icon": Icons.air,
    },
    {
      "parameterName": "Visibility",
      "value": "79%",
      "icon": Icons.visibility,
    },
    {
      "parameterName": "Humidity",
      "value": "80%",
      "icon": Icons.water_drop_outlined,
    },
    {
      "parameterName": "UV Index",
      "value": "1/10",
      "icon": Icons.sunny,
    },
    {
      "parameterName": "Cloud",
      "value": "23%",
      "icon": Icons.cloud_outlined,
    }
  ];

  Future<void> getWeatherData() async {
    if (_locationProvider.location == null) {
      return;
    }
    try {
      _isRefreshing = true;
      Map<String, dynamic> jsonData =
          await _apiService.fetchWeatherData(_locationProvider.location!);
      forecastModel.clear();
      weatherModel = WeatherModel.fromJson(jsonData);
      currentCondition =
          weatherModel.current?.condition?.text?.toLowerCase() ?? "sunny";
      extraWeatherData[0]["value"] =
          "${weatherModel.current?.feelslikeC.toString()}°";
      extraWeatherData[1]["value"] =
          "${weatherModel.current?.windKph.toString()} km/h";
      extraWeatherData[2]["value"] =
          "${weatherModel.current?.visKm.toString()} km";
      extraWeatherData[3]["value"] =
          "${weatherModel.current?.humidity.toString()}%";
      extraWeatherData[4]["value"] =
          "${weatherModel.current?.uv?.toInt().toString()}/10";
      extraWeatherData[5]["value"] =
          "${weatherModel.current?.cloud.toString()}%";
      await getWeatherForecast();
      _isRefreshing = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> getWeatherForecast() async {
    if (_locationProvider.location == null) {
      return;
    }
    try {
      List<dynamic> jsonList =
          await _apiService.fetchForecastData(_locationProvider.location!);
      hourlyForecastList.clear();
      for (Map<String, dynamic> json in jsonList) {
        forecastModel.add(ForecastModel.fromJson(json));
      }
      String currentHour = DateFormat('hh a').format(DateTime.now());
      int length = forecastModel.length;
      int newIndex = 0;
      for (int index = 0; index < length; index++) {
        for (int j = 0; j < forecastModel[index].hour!.length; j++) {
          String modelTime = DateFormat('hh a')
              .format(DateTime.parse(forecastModel[index].hour![j].time!));
          if (modelTime == currentHour) {
            newIndex = j;
            break;
          }
        }
      }
      for (int index = 0; index < length; index++) {
        for (int j = newIndex; j < forecastModel[index].hour!.length; j++) {
          if (j == newIndex) {
            forecastModel[index].hour![j].tempC = weatherModel.current!.tempC;
          }
          hourlyForecastList.add(forecastModel[index].hour![j]);
        }
      }
      setAstronomyData();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  void setAstronomyData() {
    _astronomyProvider.setSunriseTime =
        forecastModel[0].astro!.sunrise.toString();
    _astronomyProvider.setSunsetTime =
        forecastModel[0].astro!.sunset.toString();
    _astronomyProvider.setHasData = true;
  }

  String getDateTime() {
    return DateFormat.MMMMEEEEd().format(DateTime.now());
  }

  set setLocationController(LocationController provider) {
    _locationProvider = provider;
  }

  set setAstronomyController(AstronomyController provider) {
    _astronomyProvider = provider;
  }

  bool get isRefreshing => _isRefreshing;
}
