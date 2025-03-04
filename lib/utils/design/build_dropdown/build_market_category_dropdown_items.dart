import 'package:flutter/material.dart';
import '../../../models/market/get_market_category_model.dart';

List<DropdownMenuItem<int>> buildMarketCategoryDropdownItems(List<GetMarketCategoryModel> marketCategories) {
  return marketCategories.map((marketCategories) {
    return DropdownMenuItem<int>(
      value: marketCategories.id,
      child: Text(marketCategories.categoryName),
    );
  }).toList();
}