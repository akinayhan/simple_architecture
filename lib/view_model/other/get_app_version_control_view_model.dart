import 'package:flutter/material.dart';
import '../../models/other/get_app_version_control_model.dart';
import '../../services/other/get_app_version_control_service.dart';
import '../../utils/result/data_api_result.dart';

class GetAppVersionControlViewModel extends ChangeNotifier {
  DataApiResult<List<GetAppVersionControlModel>> _result = DataApiResult(success: false, messages: []);
  DataApiResult<List<GetAppVersionControlModel>> get result => _result;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<GetAppVersionControlModel> _fetchVersionControl = [];
  List<GetAppVersionControlModel> get cities => _fetchVersionControl;

  Future<void> fetchCities() async {
    _isLoading = true;
    notifyListeners();

    try {
      _result = await GetAppVersionControlService.fetchAppVersionControl();
      _fetchVersionControl = _result.data ?? [];
    } catch (e) {
      _result = DataApiResult.error(['Bir hata oluştu: $e']);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}