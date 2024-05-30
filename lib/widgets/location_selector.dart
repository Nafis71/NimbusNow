import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:nimbus_now/controllers/data_controller.dart';
import 'package:nimbus_now/controllers/location_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/DropdownMenu/dropdown_menu.dart';

class LocationSelector extends StatelessWidget {
  final SharedPreferences? preferences;
  final LocationController locationController;
  const LocationSelector({super.key, required this.preferences, required this.locationController});

  @override
  Widget build(BuildContext context) {
    return  Consumer<DataController>(builder: (context, provider, child) =>
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomDropdown<String>.search(
            items: dropdownMenuList,
            onChanged: (value) async {
              locationController.setLocation = value;
              preferences?.setString("location", value);
              provider.getWeatherForecast();
              provider.getWeatherData();
            },
            hintText: locationController.location ?? "Locating...",
            hideSelectedFieldWhenExpanded: true,
            decoration: const CustomDropdownDecoration(
                closedFillColor: Colors.white12,
                expandedFillColor: Colors.white,
                closedSuffixIcon: Icon(Icons.location_on, color: Colors.white,),
                hintStyle: TextStyle(
                    color: Colors.white
                ),
                headerStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                )
            ),
          ),
        ));
  }
}
