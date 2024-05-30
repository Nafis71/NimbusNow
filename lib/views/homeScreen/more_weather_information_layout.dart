import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../controllers/data_controller.dart';
import '../../widgets/other_weather_information.dart';

class MoreWeatherInformationLayout extends StatelessWidget {
  final Orientation orientation;

  const MoreWeatherInformationLayout({super.key, required this.orientation});

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
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
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
              builder: (context, provider, child){
                if(provider.isRefreshing){
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text("Refreshing....",style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                    ),),
                  );
                }
                return GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                      (orientation == Orientation.portrait) ? 2 : 3,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10),
                  itemCount: provider.extraWeatherData.length,
                  itemBuilder: (context, index) {
                    return OtherWeatherInformation(
                      orientation: orientation,
                      provider: provider,
                      index: index,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
