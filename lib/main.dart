import 'package:device_preview_minus/device_preview_minus.dart';
import 'package:flutter/material.dart';
import 'package:nimbus_now/app/app.dart';

void main() {
  runApp(DevicePreview(enabled:true,builder: (context)=> const NimbusNow()));
}