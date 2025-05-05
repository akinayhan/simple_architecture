import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/response/single_data_api_response.dart';
import '../../models/result/data_api_result.dart';
import '../../utils/constants/api_constants.dart';
import '../../views/navigate/navigate_to_login.dart';

class GetBaseSingleItemService {
  final String baseUrl = ApiConstants.apiUrl;

  Future<DataApiResult<T>> postRequest<T>(String endpoint, String token, Map<String, dynamic> body, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      String responseBody = response.body;

      try {
        var jsonResponse = SingleDataApiResponse.fromJson(
          jsonDecode(responseBody),
          fromJson,
        );

        if (response.statusCode == 401) {
          navigateToLoginPage();
          return DataApiResult<T>.error(jsonResponse.messages);
        }

        if (!jsonResponse.isSuccess) {
          if (jsonResponse.messages.isEmpty) {
            navigateToLoginPage();
          }
          return DataApiResult<T>.error(jsonResponse.messages);
        }

        return DataApiResult<T>.success(jsonResponse.data);
      } catch (e) {
        navigateToLoginPage();
        return DataApiResult<T>.error(['Oturumunuz süreniz sona ermiştir.']);
      }
    } catch (e) {
      navigateToLoginPage();
      return DataApiResult<T>.error(['İnternet bağlantınızı kontrol edin']);
    }
  }
}