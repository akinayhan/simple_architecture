import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/login/reset_password_model..dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/response/api_response.dart';
import '../../utils/result/api_result.dart';

class ResetPasswordService {
  static const String baseUrl = ApiConstants.apiUrl;

  Future<ApiResult> resetPassword(ResetPasswordModel resetPasswordModel) async {
    try {
      final url = Uri.parse('$baseUrl/Account/ResetPassword');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(resetPasswordModel.toJson()),
      );

      String responseBody = response.body;
      try {
        ApiResponse jsonResponse = ApiResponse.fromJson(jsonDecode(responseBody));

        if (jsonResponse.isSuccess) {
          return ApiResult.success(jsonResponse.messages);
        } else {
          return ApiResult.error(jsonResponse.messages);
        }
      } catch (e) {
        return ApiResult.error(['Beklenmeyen Hata: mesaj alanı mevcut değil : $e']);
      }
    } catch (e) {
      return ApiResult.success(['İnternet bağlantınızı kontrol edin.']);
    }
  }
}