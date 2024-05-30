import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:nimbus_now/controllers/data_controller.dart';
import 'package:nimbus_now/controllers/location_controller.dart';
import 'package:nimbus_now/models/DropdownMenu/dropdown_menu.dart';
import 'package:nimbus_now/widgets/location_selector.dart';
import 'package:nimbus_now/widgets/other_weather_information.dart';
import 'package:nimbus_now/widgets/weather_forecast_hour_layout.dart';
import 'package:nimbus_now/widgets/weather_information.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DataController dataController;
  late final LocationController locationController;
  SharedPreferences? preferences;

  @override
  void initState() {
    super.initState();
    dataController = Provider.of<DataController>(context, listen: false);
    locationController = Provider.of<LocationController>(context, listen: false);
    dataController.setLocationController = locationController;
    initializeSharedPreference();

  }

  @override
  void dispose() {
    dataController.dispose();
    locationController.dispose();
    print("Calling Dispose");
    super.dispose();
  }



  initializeSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences!.get("location") == null) {
      locationController.setLocation = "Dhaka";
    } else {
      locationController.setLocation = preferences!.get("location").toString();
    }
    loadData();
  }

  void loadData() async {
    dataController.getWeatherData();
    dataController.getWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    print("Widget Tree");
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await dataController.getWeatherData();
          await dataController.getWeatherForecast();
        },
        backgroundColor: const Color(0xff263238),
        color: const Color(0xFFFFA726),
        displacement: 60,
        child: Container(
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
                LocationSelector(preferences: preferences,locationController: locationController,),
                const WeatherForecastHourLayout(),
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
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
