import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nimbus_now/controllers/data_controller.dart';

class OtherWeatherInformation extends StatelessWidget {
  final DataController provider;
  final int index;
  const OtherWeatherInformation({super.key, required this.provider, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFFE5E8F4),
            child: Icon(provider.extraWeatherData[index]['icon'],size: 27,color: Colors.black,),
          ),
          const Gap(10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                provider.extraWeatherData[index]['parameterName'],
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Wrap(
                children: [
                  Text(
                    provider.extraWeatherData[index]['value'],
                    style: const TextStyle(
                        color: Colors.black,
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
