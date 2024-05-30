import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class SunnyScene extends StatelessWidget {
  final Orientation orientation;

  const SunnyScene({super.key, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return WrapperScene(
      sizeCanvas: Size(
          MediaQuery.of(context).size.width,
          (orientation == Orientation.portrait)
              ? MediaQuery.of(context).size.height * 0.55
              : MediaQuery.of(context).size.height * 0.7),
      colors: const [
        Colors.transparent,
        Colors.transparent,
      ],
      children: const [
        SunWidget(
          sunConfig:
              SunConfig(blurSigma: 30.00, animMidMill: 3000, animOutMill: 3000),
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
