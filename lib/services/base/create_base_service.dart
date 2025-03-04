import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/navigate/navigate_to_login.dart';
import '../../utils/response/api_response.dart';
import '../../utils/result/api_result.dart';

class CreateBaseService {
  final String baseUrl;

  CreateBaseService(this.baseUrl);

  Future<ApiResult> post(String endpoint, dynamic model, String authToken) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(model.toJson()),
      );

      String responseBody = response.body;

      try {
        ApiResponse jsonResponse = ApiResponse.fromJson(jsonDecode(responseBody));

        if (jsonResponse.isSuccess) {
          return ApiResult.success(jsonResponse.messages);
        } else {
          if (jsonResponse.messages.isEmpty || response.statusCode == 401) {
            navigateToLoginPage();
          }
          return ApiResult.error(jsonResponse.messages);
        }
      } catch (e) {
        return ApiResult.error(['Beklenmeyen Hata: mesaj alanı mevcut değil']);
      }
    } catch (e) {
      return ApiResult.error(['İnternet bağlantınızı kontrol edin.']);
    }
  }
}