import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nimbus_now/controllers/astronomy_controller.dart';
import 'package:nimbus_now/controllers/data_controller.dart';
import 'package:nimbus_now/controllers/location_controller.dart';
import 'package:nimbus_now/views/homeScreen/astronomy_layout.dart';
import 'package:nimbus_now/views/homeScreen/more_weather_information_layout.dart';
import 'package:nimbus_now/widgets/location_selector.dart';
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
  late final AstronomyController astronomyController;
  SharedPreferences? preferences;

  @override
  void initState() {
    super.initState();
    dataController = Provider.of<DataController>(context, listen: false);
    locationController =
        Provider.of<LocationController>(context, listen: false);
    astronomyController =
        Provider.of<AstronomyController>(context, listen: false);
    dataController.setLocationController = locationController;
    dataController.setAstronomyController = astronomyController;
    initializeSharedPreference();
  }

  @override
  void dispose() {
    dataController.dispose();
    locationController.dispose();
    super.dispose();
  }

  initializeSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences!.get("location") == null) {
      await locationController.getCurrentLocation();
      preferences!
          .setString("location", locationController.location.toString());
      await loadData();
    } else {
      locationController.setLocation = preferences!.get("location").toString();
      await loadData();
    }
  }

  Future<void> loadData() async {
    await dataController.getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return RefreshIndicator(
          onRefresh: () async {
            await loadData();
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
                    orientation: orientation,
                    dataController: dataController,
                    locatorFunction: () async {
                      locationController.setLocation = "Locating...";
                      await locationController.getCurrentLocation();
                      preferences!.setString(
                          "location", locationController.location.toString());
                      await loadData();
                    },
                  ),
                  LocationSelector(
                    preferences: preferences,
                    dataController: dataController,
                  ),
                  const WeatherForecastHourLayout(),
                  const Gap(5),
                  MoreWeatherInformationLayout(
                    orientation: orientation,
                  ),
                  const Gap(10),
                  const AstronomyLayout(),
                  const Gap(10),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
