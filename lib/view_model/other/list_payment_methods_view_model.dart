import 'package:flutter/foundation.dart';
import '../../models/other/payment_method_model.dart';
import '../../models/other/get_payment_methods_request_model.dart';
import '../../services/other/list_payment_methods_service.dart';
import '../../models/result/data_api_result.dart';
class ListPaymentMethodsViewModel extends ChangeNotifier {
  DataApiResult<List<PaymentMethodModel>> _result = DataApiResult(success: false, messages: []);
  DataApiResult<List<PaymentMethodModel>> get result => _result;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<PaymentMethodModel> _paymentMethods  = [];
  List<PaymentMethodModel> get paymentMethods => _paymentMethods ;


  Future<void> fetchPaymentMethods(GetPaymentMethodsRequestModel requestModel) async {
    _isLoading = true;
    notifyListeners();

    try {
      _result = await ListPaymentMethodsService.fetchPaymentMethods(requestModel);
      _paymentMethods = _result.data ?? [];
    } catch (e) {
      _result = DataApiResult.error(['Bir hata oluştu: $e']);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}