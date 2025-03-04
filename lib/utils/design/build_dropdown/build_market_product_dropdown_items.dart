import 'package:flutter/material.dart';
import '../../../models/market/get_market_product_model.dart';

List<DropdownMenuItem<int>> buildMarketProductDropdownItems(List<GetMarketProductModel> marketProduct) {
  return marketProduct.map((marketProduct) {
    return DropdownMenuItem<int>(
      value: marketProduct.id,
      child: Text(marketProduct.productName),
    );
  }).toList();
}