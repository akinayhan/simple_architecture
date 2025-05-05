import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/response/api_response.dart';
import '../../models/result/api_result.dart';
import '../../utils/constants/api_constants.dart';
import '../../views/navigate/navigate_to_login.dart';

abstract class UpdateBaseService {
  final String baseUrl = ApiConstants.apiUrl;

  Future<ApiResult> postRequest(String endpoint, Map<String, dynamic> body, String authToken) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(body),
      );
      return handleResponse(response);

    } catch (e) {
      return ApiResult.error(['İnternet bağlantınızı kontrol edin.']);
    }

  }

  Future<ApiResult> postRequestList(String endpoint, List<Map<String, dynamic>> body, String authToken) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(body),
      );
      return handleResponse(response);
    } catch (e) {
      return ApiResult.error(['İnternet bağlantınızı kontrol edin.']);
    }
  }

  ApiResult handleResponse(http.Response response) {
    try {
      final jsonResponse = ApiResponse.fromJson(jsonDecode(response.body));

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
  }
}