import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nimbus_now/controllers/data_controller.dart';
import 'package:nimbus_now/widgets/hot_scene.dart';
import 'package:nimbus_now/widgets/overcast_scene.dart';
import 'package:nimbus_now/widgets/rain_scene.dart';
import 'package:nimbus_now/widgets/sunny_scene.dart';
import 'package:nimbus_now/widgets/thunder_scene.dart';
import 'package:provider/provider.dart';

class WeatherInformation extends StatelessWidget {
  final DataController dataController;
  final Function locatorFunction;
  final Orientation orientation;

  const WeatherInformation(
      {super.key,
      required this.dataController,
      required this.locatorFunction,
      required this.orientation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (orientation == Orientation.portrait)
          ? MediaQuery.of(context).size.height * 0.55
          : MediaQuery.of(context).size.height * 0.7,
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Animate(
            effects: const [
              FadeEffect(
                  duration: Duration(seconds: 5), curve: Curves.decelerate)
            ],
            child:
                Consumer<DataController>(builder: (context, provider, child) {
              if (provider.currentCondition!.contains("thunder")) {
                return ThunderScene(
                  orientation: orientation,
                );
              } else if (provider.currentCondition!.contains("overcast")) {
                return OvercastScene(
                  orientation: orientation,
                );
              } else if (provider.currentCondition!.contains("rain")) {
                return RainScene(
                  orientation: orientation,
                );
              } else if (provider.currentCondition!.contains("hot") ||
                  provider.currentCondition!.contains("haze")) {
                return HotScene(
                  orientation: orientation,
                );
              }
              return SunnyScene(
                orientation: orientation,
              );
            }),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            right: 10,
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: "Nimbus",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
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
            top: MediaQuery.of(context).size.height * 0.415,
            left: 20,
            child: Consumer<DataController>(
              builder: (context, provider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                provider.weatherModel.current?.tempC.toString(),
                            style: const TextStyle(
                                fontSize: 55, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: (provider.weatherModel.current?.tempC != null)
                              ? "°"
                              : "",
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFeatures: [FontFeature.superscripts()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    provider.weatherModel.current?.condition?.text.toString() ??
                        "",
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.39,
            left: 20,
            child: Consumer<DataController>(
              builder: (context, provider, child) {
                if (provider.isRefreshing) {
                  return const Text(
                    "Refreshing...",
                    style: TextStyle(color: Colors.white),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Positioned(
              top: (orientation == Orientation.portrait)
                  ? MediaQuery.of(context).size.height * 0.43
                  : MediaQuery.of(context).size.height * 0.48,
              right: 20,
              child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => locatorFunction(),
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.white,
                    size: 35,
                  ))),
          Positioned(
            top: (orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height * 0.1
                : MediaQuery.of(context).size.height * 0.15,
            right: 10,
            child: Consumer<DataController>(
              builder: (context, provider, child) => Column(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFFFFA726),
                    size: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "${provider.weatherModel.location?.name ?? "Locating..."} ",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: (provider.weatherModel.location?.country ==
                                  "United States of America")
                              ? "USA"
                              : provider.weatherModel.location?.country,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "${provider.getDateTime()} ",
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
