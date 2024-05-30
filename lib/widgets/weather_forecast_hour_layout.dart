import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nimbus_now/controllers/data_controller.dart';
import 'package:provider/provider.dart';

class WeatherForecastHourLayout extends StatelessWidget {
  const WeatherForecastHourLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      padding: const EdgeInsets.all(5),
      height: 120,
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
        builder: (context, provider, child) {
          if(provider.isRefreshing){
             return Text("Refreshing....",style: TextStyle(
               color: Colors.white,
               fontSize: 17
             ),);
          }
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.hourlyForecastList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    const Gap(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          getTime(provider, index),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          getIcon(provider, index),
                          color: Colors.white,
                        ),
                        Text(
                          "${provider.hourlyForecastList[index].tempC.toString()}°",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              });
        },
      ),
    );
  }

  IconData getIcon(DataController provider, int index) {
    if (provider.hourlyForecastList[index].willItRain == 1) {
      return Ionicons.rainy_outline;
    } else if (provider.hourlyForecastList[index].isDay == 1) {
      return Ionicons.cloudy_outline;
    }
    return Ionicons.cloudy_night_outline;
  }

  String getTime(DataController provider, int index) {
    String currentTime = DateFormat('hh a').format(DateTime.now());
    String providedTime = DateFormat('hh a')
        .format(DateTime.parse(provider.hourlyForecastList[index].time!));
    if (currentTime == providedTime) {
      return "Now";
    }
    return DateFormat('hh:mm a')
        .format(DateTime.parse(provider.hourlyForecastList[index].time!));
  }
}
