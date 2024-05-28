import 'package:flutter/material.dart';
import 'package:nimbus_now/views/homeScreen/home_screen.dart';
import 'package:provider/provider.dart';

class NimbusNow extends StatelessWidget {
  const NimbusNow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
