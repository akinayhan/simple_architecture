import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/result/api_result.dart';
import '../../utils/constants/api_constants.dart';

class LogOutService {
  static const String baseUrl = ApiConstants.apiUrl;

  Future<ApiResult> logOut(String authToken) async {
    try {
      final url = Uri.parse('$baseUrl/Account/Logout');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      String responseBody = response.body;
      try {
        dynamic jsonResponse = jsonDecode(responseBody);
        if (jsonResponse['isSuccess'] != null && jsonResponse['isSuccess']) {
          if (jsonResponse.containsKey('messages')) {
            List<String> messages = List<String>.from(
                jsonResponse['messages']);
            return ApiResult.success(messages);
          } else {
            return ApiResult.success([]);
          }
        } else {
          if (jsonResponse.containsKey('messages')) {
            List<String> errorMessages = List<String>.from(
                jsonResponse['messages']);
            return ApiResult.error(errorMessages);
          } else {
            return ApiResult.error(
                ['Oturumunuz Sona Ermiştir.']);
          }
        }
      } catch (e) {
        return ApiResult.error(
            ['Oturum Süreniz Sona Ermiştir.']);
      }
    } catch (e) {
      return ApiResult.error(['İnternet bağlantınızı kontrol edin.']);
    }
  }
}