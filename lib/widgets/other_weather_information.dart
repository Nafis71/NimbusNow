import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nimbus_now/controllers/data_controller.dart';

class OtherWeatherInformation extends StatelessWidget {
  final DataController provider;
  final int index;
  final Orientation orientation;

  const OtherWeatherInformation(
      {super.key,
      required this.provider,
      required this.index,
      required this.orientation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13),
      padding: const EdgeInsets.all(1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            child: Icon(
              provider.extraWeatherData[index]['icon'],
              size: 30,
              color: Colors.white,
            ),
          ),
          const Gap(10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provider.extraWeatherData[index]['parameterName'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Wrap(
                children: [
                  Text(
                    provider.extraWeatherData[index]['value'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
