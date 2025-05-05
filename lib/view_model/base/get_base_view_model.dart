import 'package:flutter/foundation.dart';
import '../../models/result/data_api_result.dart';
abstract class BaseViewModel<T> extends ChangeNotifier {
  DataApiResult<List<T>> _result = DataApiResult(success: false, messages: []);
  DataApiResult<List<T>> get result => _result;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<T> _items = [];
  List<T> get items => _items;

  Future<void> fetchData(Future<DataApiResult<List<T>>> Function() fetchFunction) async {
    _isLoading = true;
    notifyListeners();

    try {
      _result = await fetchFunction();
      _items = _result.data ?? [];
    } catch (e) {
      _result = DataApiResult.error(['Bir hata oluştu: $e']);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
