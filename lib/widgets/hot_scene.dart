import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class HotScene extends StatelessWidget {
  const HotScene({super.key});

  @override
  Widget build(BuildContext context) {
    return WrapperScene(
      sizeCanvas: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.55),
      colors: const [
        Color(0xFFd50000),
        Color(0xFFffd54f),
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
