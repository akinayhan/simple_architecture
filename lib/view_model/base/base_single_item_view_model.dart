import 'package:flutter/foundation.dart';
import '../../models/result/data_api_result.dart';
abstract class BaseSingleItemViewModel<T> extends ChangeNotifier {
  DataApiResult<T> _result = DataApiResult(success: false, messages: []);
  DataApiResult<T> get result => _result;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  T? _item;
  T? get item => _item;

  Future<void> fetchData(Future<DataApiResult<T>> Function() fetchFunction) async {
    _isLoading = true;
    notifyListeners();

    try {
      _result = await fetchFunction();
      _item = _result.data;
    } catch (e) {
      _result = DataApiResult.error(['Bir hata oluştu: $e']);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
