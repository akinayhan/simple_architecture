import 'package:flutter/foundation.dart';
import '../../models/other/district_model.dart';
import '../../services/other/district_service.dart';
import '../../utils/result/data_api_result.dart';

class DistrictViewModel extends ChangeNotifier {
  DataApiResult<List<DistrictModel>> _result = DataApiResult(success: false, messages: []);
  DataApiResult<List<DistrictModel>> get result => _result;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<DistrictModel> _districts = [];
  List<DistrictModel> get districts => _districts;

  Future<void> fetchDistricts(int cityId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _result = await DistrictService.fetchAllDistricts(cityId);
      _districts = _result.data ?? [];
    } catch (e) {
      _result = DataApiResult.error(['Bir hata oluştu: $e']);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearDistricts() {
    _districts.clear();
    notifyListeners();
  }
}