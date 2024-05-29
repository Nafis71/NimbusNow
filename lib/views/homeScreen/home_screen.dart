import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gap/gap.dart';
import 'package:nimbus_now/controllers/data_controller.dart';
import 'package:nimbus_now/widgets/other_weather_information.dart';
import 'package:nimbus_now/widgets/weather_information.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DataController dataController;

  @override
  void initState() {
    dataController = Provider.of<DataController>(context, listen: false);
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    dataController.dispose();
    super.dispose();
  }

  void loadData() async {
    dataController.getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff263238),
                Color(0xff5b666e),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.1),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherInformation(
                dataController: dataController,
              ),
              Container(
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
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return const Row(
                        children: [
                          Gap(20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "7:00 PM",
                                style: TextStyle(
                                    fontSize: 12,color:Colors.white, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.cloud_outlined,color:Colors.white,),
                              Text(
                                "16°",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold,color:Colors.white,),
                              )
                            ],
                          ),
                        ],
                      );
                    }),
              ),
              const Gap(5),
              Container(
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
                        builder: (context, provider, child) => GridView.builder(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
