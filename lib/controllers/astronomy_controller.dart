import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AstronomyController extends ChangeNotifier {
  String _sunriseTime = "";
  String _sunsetTime = "";
  int totalTime = 0;
  bool _hasData = false;

  String get sunriseTime => _sunriseTime;

  set setSunriseTime(String value) {
    _sunriseTime = value;
  }

  String get sunsetTime => _sunsetTime;

  set setSunsetTime(String value) {
    _sunsetTime = value;
  }

  bool get hasData => _hasData;

  set setHasData(bool value) {
    _hasData = value;
    notifyListeners();
  }

  int getCurrentHour() {
    int currentHour =
        int.tryParse(DateFormat('hh').format(DateTime.now())) ?? 0;
    String currentPeriod = DateFormat('a').format(DateTime.now());
    if (currentPeriod == 'PM' && (currentHour + 12) <= getSunsetHour()) {
      return currentHour + 12;
    }
    if (currentPeriod == 'PM' && (currentHour + 12) > getSunsetHour()) {
      return getSunsetHour();
    }
    return currentHour;
  }

  int getSunsetHour() {
    int sunsetHour = int.tryParse(DateFormat('hh')
            .format(DateTime.parse(formatTimeString(_sunsetTime)))) ?? 0;
    return sunsetHour + 12;
  }

  int getSunriseHour() {
    return int.tryParse(DateFormat('hh')
            .format(DateTime.parse(formatTimeString(_sunriseTime)))) ?? 0;
  }

  String formatTimeString(String timeString) {
    final RegExp timePattern = RegExp(r'(\d{2}):(\d{2}) (AM|PM)');
    final match = timePattern.firstMatch(timeString);

    if (match != null) {
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String period = match.group(3)!;

      if (period == "PM" && hour != 12) {
        hour += 12;
      } else if (period == "AM" && hour == 12) {
        hour = 0;
      }

      return "2024-01-01T${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00";
    }
    throw const FormatException("Invalid time format");
  }
}
