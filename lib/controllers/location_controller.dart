import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nimbus_now/controllers/gps_location.dart';

class LocationController extends ChangeNotifier {
  String? _location;

  String? get location => _location;

  set setLocation(String? location) {
    _location = location;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await GpsLocation.determinePosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      _location = placemarks.last.locality.toString();
      print(_location);
      notifyListeners();
    } catch (e) {
      _location = "New York";
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }
}
