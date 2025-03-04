import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/login/sign_up_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/response/api_response.dart';
import '../../utils/result/api_result.dart';

class SignUpService {
  static const String baseUrl = ApiConstants.apiUrl;

  Future<ApiResult> signUpOperation(SignUpModel signUpModel) async {
    try {
      final url = Uri.parse('$baseUrl/Account/Register');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(signUpModel.toJson()),
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
        return ApiResult.error(['Beklenmeyen Hata: mesaj alanı mevcut değil']);
      }
    } catch (e) {
      return ApiResult.success(['İnternet bağlantınızı kontrol edin.']);
    }
  }
}