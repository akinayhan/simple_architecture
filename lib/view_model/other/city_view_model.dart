import 'package:flutter/material.dart';
import '../../models/other/city_model.dart';
import '../../services/other/city_service.dart';
import '../../utils/result/data_api_result.dart';

class CityViewModel extends ChangeNotifier {
  DataApiResult<List<CityModel>> _result = DataApiResult(success: false, messages: []);
  DataApiResult<List<CityModel>> get result => _result;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CityModel> _cities = [];
  List<CityModel> get cities => _cities;

  Future<void> fetchCities() async {
    _isLoading = true;
    notifyListeners();

    try {
      _result = await CityService.fetchCities();
      _cities = _result.data ?? [];
    } catch (e) {
      _result = DataApiResult.error(['Bir hata oluştu: $e']);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}