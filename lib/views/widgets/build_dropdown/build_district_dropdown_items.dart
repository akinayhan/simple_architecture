import 'package:flutter/material.dart';
import '../../../models/other/district_model.dart';

List<DropdownMenuItem<int>> buildDistrictDropdownItems(List<DistrictModel> districts, int cityId) {
  return districts
      .where((district) => district.cityId == cityId)
      .map((district) {
    return DropdownMenuItem<int>(
      value: district.id,
      child: Text(district.name),
    );
  })
      .toList();
}