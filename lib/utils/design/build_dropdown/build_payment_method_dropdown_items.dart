import 'package:flutter/material.dart';
import '../../../models/other/payment_method_model.dart';

List<DropdownMenuItem<int>> buildPaymentMethodDropdownItems(List<PaymentMethodModel> paymentMethods) {
  return paymentMethods.map((paymentMethods) {
    return DropdownMenuItem<int>(
      value: paymentMethods.id,
      child: Text(paymentMethods.name),
    );
  }).toList();
}