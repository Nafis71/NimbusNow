import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class SunnyScene extends StatelessWidget {
  const SunnyScene({super.key});

  @override
  Widget build(BuildContext context) {
    return WrapperScene(
      sizeCanvas: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.5),
      colors: const [
        Color(0xFF2C8EEC),
        Color(0xFF0A75F2),
      ],
      children: const [
        SunWidget(
          sunConfig: SunConfig(
              blurSigma: 30.00, animMidMill: 3000, animOutMill: 3000),
        ),
        CloudWidget(),
        WindWidget(
          windConfig: WindConfig(
            color: Colors.white,
            slideDurMill: 2000,
          ),
        ),
      ],
    );
  }
}
