import 'package:device_preview_minus/device_preview_minus.dart';
import 'package:flutter/material.dart';
import 'package:nimbus_now/controllers/astronomy_controller.dart';
import 'package:nimbus_now/controllers/data_controller.dart';
import 'package:nimbus_now/controllers/location_controller.dart';
import 'package:nimbus_now/views/homeScreen/home_screen.dart';
import 'package:provider/provider.dart';

class NimbusNow extends StatelessWidget {
  const NimbusNow({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> DataController()),
        ChangeNotifierProvider(create: (context)=> LocationController()),
        ChangeNotifierProvider(create: (context)=> AstronomyController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: const HomeScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
