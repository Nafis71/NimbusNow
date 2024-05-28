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
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFFE5E8F4),
            child: Icon(provider.extraWeatherData[index]['icon'],size: 27,color: Colors.black,),
          ),
          Gap(10),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                provider.extraWeatherData[index]['parameterName'],
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Wrap(
                children: [
                  Text(
                    provider.extraWeatherData[index]['value'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
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
