import 'package:flutter/material.dart';
import '../../../models/other/status_model.dart';

List<DropdownMenuItem<bool>> buildStatusDropdownItems(List<StatusModel> statusModelList) {
  return statusModelList.map((statusModel) {
    return DropdownMenuItem<bool>(
      value: statusModel.status,
      child: Text(statusModel.name),
    );
  }).toList();
}


