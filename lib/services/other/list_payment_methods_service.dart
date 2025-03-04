import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/other/payment_method_model.dart';
import '../../models/other/get_payment_methods_request_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/navigate/navigate_to_login.dart';
import '../../utils/response/data_api_response.dart';
import '../../utils/result/data_api_result.dart';

class ListPaymentMethodsService {
  static const String baseUrl = ApiConstants.apiUrl;

  static Future<DataApiResult<List<PaymentMethodModel>>> fetchPaymentMethods(GetPaymentMethodsRequestModel requestModel) async {
    try {

      final url = Uri.parse('$baseUrl/General/GetPaymentMethod');
      final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      String responseBody = response.body;

      try {
        DataApiResponse<PaymentMethodModel> jsonResponse = DataApiResponse.fromJson(
          jsonDecode(responseBody),
              (data) => PaymentMethodModel.fromJson(data),
        );

        if (response.statusCode == 401) {
          navigateToLoginPage();
          return DataApiResult<List<PaymentMethodModel>>.error(jsonResponse.messages);
        }

        if (!jsonResponse.isSuccess) {
          if (jsonResponse.messages.isEmpty) {
            navigateToLoginPage();
          }
          return DataApiResult<List<PaymentMethodModel>>.error(jsonResponse.messages);
        }
        return DataApiResult<List<PaymentMethodModel>>.success(jsonResponse.items);
      } catch (e) {
        navigateToLoginPage();
        return DataApiResult<List<PaymentMethodModel>>.error(['Oturumunuz süreniz sona ermiştir.']);
      }
    } catch (e) {
      if (e is DataApiResult && e.messages.isEmpty) {
        navigateToLoginPage();
      }
      return DataApiResult<List<PaymentMethodModel>>.error(['İnternet bağlantınızı kontrol edin']);
    }
  }
}