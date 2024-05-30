import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class OvercastScene extends StatelessWidget {
  final Orientation orientation;

  const OvercastScene({super.key, required this.orientation});

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
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 270,
            color: Color(0xcdbdbdbd),
            x: 119,
            y: -50,
            scaleBegin: 1,
            scaleEnd: 1.1,
            slideX: 11,
            slideY: 13,
            slideDurMill: 4000,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 250,
            color: Color(0x92fafafa),
            x: 20,
            y: 3,
            scaleBegin: 1,
            scaleEnd: 1.08,
            slideX: 20,
            slideY: 0,
            slideDurMill: 3000,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 160,
            color: Color(0xb5fafafa),
            x: 140,
            y: 97,
            scaleBegin: 1,
            scaleEnd: 1.1,
            slideX: 20,
            slideY: 4,
            slideDurMill: 2000,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 230,
            color: Color(0xb5fafafa),
            x: 200,
            y: 97,
            scaleBegin: 1,
            scaleEnd: 1.1,
            slideX: 20,
            slideY: 4,
            slideDurMill: 2000,
          ),
        )
      ],
    );
  }
}
