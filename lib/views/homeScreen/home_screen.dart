import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gap/gap.dart';
import 'package:nimbus_now/controllers/data_controller.dart';
import 'package:nimbus_now/widgets/other_weather_information.dart';
import 'package:nimbus_now/widgets/weather_information.dart';
import 'package:provider/provider.dart';
import 'package:weather_animation/weather_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DataController dataController;

  @override
  void initState() {
    dataController = Provider.of<DataController>(context,listen: false);
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    dataController.dispose();
    super.dispose();
  }

  void loadData() async{
    dataController.getWeatherData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherInformation(dataController: dataController,),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    const Text(
                      "Weather Now",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Consumer<DataController>(builder: (context,provider,child)=>GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 4),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return OtherWeatherInformation(provider: provider, index: index,);
                      },
                    ),),
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
