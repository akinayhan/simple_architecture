import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/response/data_api_response.dart';
import '../../models/result/data_api_result.dart';
import '../../utils/constants/api_constants.dart';
import '../../views/navigate/navigate_to_login.dart';

class GetBaseService {
  final String baseUrl = ApiConstants.apiUrl;

  Future<DataApiResult<List<T>>> postRequest<T>(String endpoint, String token, Map<String, dynamic> body, T Function(dynamic) fromJson) async {
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
        DataApiResponse<T> jsonResponse = DataApiResponse.fromJson(
          jsonDecode(responseBody),
          fromJson,
        );

        if (response.statusCode == 401) {
          navigateToLoginPage();
          return DataApiResult<List<T>>.error(jsonResponse.messages);
        }

        if (!jsonResponse.isSuccess) {
          if (jsonResponse.messages.isEmpty) {
            navigateToLoginPage();
          }
          return DataApiResult<List<T>>.error(jsonResponse.messages);
        }
        return DataApiResult<List<T>>.success(jsonResponse.items);
      } catch (e) {
        navigateToLoginPage();
        return DataApiResult<List<T>>.error(['Oturumunuz süreniz sona ermiştir.']);
      }
    } catch (e) {
      navigateToLoginPage();
      return DataApiResult<List<T>>.error(['İnternet bağlantınızı kontrol edin']);
    }
  }
}