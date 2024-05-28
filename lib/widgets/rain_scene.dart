import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class RainScene extends StatelessWidget {
  const RainScene({super.key});

  @override
  Widget build(BuildContext context) {
    return WrapperScene(
      sizeCanvas: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.55),
      colors: const [
        Color(0xff263238),
        Color(0xff78909c),

      ],
      children: const [
        WindWidget(
          windConfig: WindConfig(
            width: 5,
            y: 208,
            windGap: 10,
            blurSigma: 6,
            color: Color(0xff607d8b),
            slideXEnd: 350,
            slideXStart: 0,
            pauseEndMill: 6000,
            slideDurMill: 1000,
          ),
        ),
        RainWidget(
          rainConfig: RainConfig(
            count: 40,
            lengthDrop: 13,
            widthDrop: 4,
            color: Color(0x9978909c),
            isRoundedEndsDrop: true,
            fallRangeMinDurMill: 500,
            fallRangeMaxDurMill: 1500,
            areaXStart: 41,
            areaXEnd: 364,
            areaYStart: 208,
            areaYEnd: 620,
            slideX: 2,
            slideY: 0,
            slideDurMill: 2000,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 250,
            color: Color(0xad90a4ae),
            x: 20,
            y: 3,
            scaleBegin: 1,
            slideX: 20,
            slideY: 0,
            slideDurMill: 3000,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 250,
            color: Color(0xad90a4ae),
            x: 150,
            y: 3,
            scaleBegin: 1,
            slideX: 20,
            slideY: 0,
            slideDurMill: 3000,
          ),
        ),
        WindWidget(
          windConfig: WindConfig(
            width: 7,
            y: 300,
            windGap: 15,
            blurSigma: 7,
            color: Color(0xff607d8b),
            slideXStart: 0,
            slideXEnd: 350,
            pauseStartMill: 50,
            pauseEndMill: 6000,
            slideDurMill: 1000,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 160,
            color: Color(0xb1607d8b),
            x: 140,
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
