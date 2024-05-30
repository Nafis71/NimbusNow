import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class HotScene extends StatelessWidget {
  final Orientation orientation;

  const HotScene({super.key, required this.orientation});

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
          sunConfig: SunConfig(
            width: 360,
            blurSigma: 17,
            coreColor: Color(0xfff57c00),
            midColor: Color(0xffffee58),
            outColor: Color(0xffffa726),
            animMidMill: 1500,
            animOutMill: 1500,
          ),
        )
      ],
    );
  }
}
