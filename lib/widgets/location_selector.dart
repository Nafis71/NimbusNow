import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:nimbus_now/controllers/data_controller.dart';
import 'package:nimbus_now/controllers/location_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/DropdownMenu/dropdown_menu.dart';

class LocationSelector extends StatelessWidget {
  final SharedPreferences? preferences;
  final DataController dataController;

  const LocationSelector(
      {super.key, required this.preferences, required this.dataController});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationController>(
      builder: (context, locationProvider, child) => Padding(
        padding: const EdgeInsets.all(8),
        child: CustomDropdown<String>.search(
          headerBuilder: (context, _) {
            return Text(
              locationProvider.location ?? "Locating...",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            );
          },
          items: dropdownMenuList,
          onChanged: (value) async {
            locationProvider.setLocation = value;
            preferences?.setString("location", value);
            await dataController.getWeatherForecast();
            await dataController.getWeatherData();
          },
          hintText: locationProvider.location ?? "Locating...",
          hideSelectedFieldWhenExpanded: true,
          decoration: const CustomDropdownDecoration(
            closedFillColor: Colors.white12,
            expandedFillColor: Colors.white,
            closedSuffixIcon: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
