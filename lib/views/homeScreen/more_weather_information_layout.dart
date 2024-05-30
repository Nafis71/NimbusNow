import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../controllers/data_controller.dart';
import '../../widgets/other_weather_information.dart';

class MoreWeatherInformationLayout extends StatelessWidget {
  const MoreWeatherInformationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          const Text(
            "Weather Now",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          const Gap(5),
          Container(
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
            alignment: Alignment.center,
            child: Consumer<DataController>(
              builder: (context, provider, child) =>
                  GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10),
                    itemCount: provider.extraWeatherData.length,
                    itemBuilder: (context, index) {
                      return OtherWeatherInformation(
                        provider: provider,
                        index: index,
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
