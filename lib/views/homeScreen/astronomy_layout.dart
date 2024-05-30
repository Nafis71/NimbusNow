import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nimbus_now/controllers/astronomy_controller.dart';
import 'package:provider/provider.dart';

class AstronomyLayout extends StatelessWidget {
  const AstronomyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.14),
              blurRadius: 10,
              blurStyle: BlurStyle.normal,
              spreadRadius: 2,
              offset: const Offset(0, 2))
        ],
      ),
      child: Consumer<AstronomyController>(
        builder: (context, provider, child) {
          if (!provider.hasData) {
            return const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Refreshing..",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Ionicons.partly_sunny_sharp,
                          color: Colors.white,
                          size: 27,
                        ),
                        Text(
                          "Sunrise",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Ionicons.cloudy_night_sharp,
                          color: Colors.white,
                          size: 27,
                        ),
                        Text(
                          "Sunset",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        )
                      ],
                    ),
                  ],
                ),
                FlutterSlider(
                  values: [provider.getCurrentHour().toDouble()],
                  max: provider.getSunsetHour().toDouble(),
                  min: provider.getSunriseHour().toDouble(),
                  selectByTap: false,
                  tooltip: FlutterSliderTooltip(
                    disabled: true,
                  ),
                  handler: FlutterSliderHandler(
                      child: const Icon(
                        Icons.sunny_snowing,
                        color: Colors.white,
                        size: 35,
                      ),
                      decoration:
                          const BoxDecoration(color: Colors.transparent)),
                  disabled: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.sunriseTime,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      provider.sunsetTime,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
