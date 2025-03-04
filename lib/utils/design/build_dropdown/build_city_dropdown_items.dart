import 'package:flutter/material.dart';
import '../../../models/other/city_model.dart';

List<DropdownMenuItem<int>> buildCityDropdownItems(List<CityModel> cities) {
  return cities.map((city) {
    return DropdownMenuItem<int>(
      value: city.id,
      child: Text(city.name),
    );
  }).toList();
}