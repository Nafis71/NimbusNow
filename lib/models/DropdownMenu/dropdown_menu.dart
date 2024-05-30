import 'package:flutter/material.dart';

class DropdownList{
  String countryName;
  IconData icon;

  DropdownList(this.countryName, this.icon);
}

List<String> dropdownMenuList = [
  // USA
  'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix',

  // Canada
  'Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa',

  // UK
  'London', 'Birmingham', 'Manchester', 'Glasgow', 'Liverpool',

  // Australia
  'Sydney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide',

  // Germany
  'Berlin', 'Hamburg', 'Munich', 'Cologne', 'Frankfurt',

  // France
  'Paris', 'Marseille', 'Lyon', 'Toulouse', 'Nice',

  // Japan
  'Tokyo', 'Osaka', 'Yokohama', 'Nagoya', 'Sapporo',

  // China
  'Beijing', 'Shanghai', 'Shenzhen', 'Guangzhou', 'Chengdu',

  // Brazil
  'São Paulo', 'Rio de Janeiro', 'Brasília', 'Salvador', 'Fortaleza',

  // India
  'Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Chennai',

  // South Africa
  'Johannesburg', 'Cape Town', 'Durban', 'Pretoria', 'Port Elizabeth',

  // Russia
  'Moscow', 'Saint Petersburg', 'Novosibirsk', 'Yekaterinburg', 'Kazan',

  // Italy
  'Rome', 'Milan', 'Naples', 'Turin', 'Palermo',

  //Bangladesh
  'Jamalpur','Dhaka', 'Chittagong', 'Sylhet','Tungi'
];