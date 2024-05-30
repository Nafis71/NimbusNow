import 'package:flutter/material.dart';

class LocationController extends ChangeNotifier{
  String _location = "Dhaka";

  String get location => _location;

  set setLocation(String location) {
    _location = location;
  }

}