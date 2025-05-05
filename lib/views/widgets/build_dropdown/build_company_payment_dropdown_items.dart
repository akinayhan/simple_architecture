import 'package:flutter/material.dart';
import '../../../models/other/company_payment_time_model.dart';

List<DropdownMenuItem<int>> buildCompanyPaymentDropdownItems(List<CompanyPaymentTimeModel> companyPaymentTimeList) {
  return companyPaymentTimeList.map((companyPaymentTimeModel) {
    return DropdownMenuItem<int>(
      value: companyPaymentTimeModel.duration,
      child: Text(companyPaymentTimeModel.name),
    );
  }).toList();
}