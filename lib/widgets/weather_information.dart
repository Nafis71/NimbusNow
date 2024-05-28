import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';
class WeatherInformation extends StatelessWidget {
  const WeatherInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          WrapperScene(
            sizeCanvas: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.5),
            colors: const [
              Color(0xFF2C8EEC),
              Color(0xFF0A75F2),
            ],
            children: const [
              SunWidget(
                sunConfig: SunConfig(
                    blurSigma: 30.00,
                    animMidMill: 3000,
                    animOutMill: 3000),
              ),
              CloudWidget(),
              WindWidget(
                windConfig: WindConfig(
                  color: Colors.white,
                  slideDurMill: 2000,
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            right: 10,
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: "Nimbus",
                    style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w700)),
                TextSpan(
                    text: "Now",
                    style: TextStyle(
                        color: Color(0xFFFFA726),
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.39,
            left: 20,
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                      text: "20",
                      style: TextStyle(
                          fontSize: 55, fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: "°",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFeatures: [FontFeature.superscripts()],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: 20,
            child: const Text(
              "Windy",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          )
        ],
      ),
    );
  }
}
