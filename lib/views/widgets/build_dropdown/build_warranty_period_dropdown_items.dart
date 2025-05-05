import 'package:flutter/material.dart';
import '../../../models/other/warrant_period_model.dart';

List<DropdownMenuItem<int>> buildWarrantyPeriodDropdownItems(List<WarrantPeriodModel> warrantPeriodModelList) {
  return warrantPeriodModelList.map((model) {
    return DropdownMenuItem<int>(
      value: model.duration,
      child: Text('${model.duration} Ay'),
    );
  }).toList();
}
