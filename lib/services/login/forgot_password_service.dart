import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/login/forgot_password_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/response/my_data_api_response.dart';
import '../../utils/result/data_api_result.dart';

class ForgotPasswordService {
  static const String baseUrl = ApiConstants.apiUrl;

  static Future<DataApiResult<ForgotPasswordModel>> sendPasswordResetRequest(String email) async {
    try {
      final url = Uri.parse('$baseUrl/Account/ForgotPassword?email=$email');
      final response = await http.get(url);

      final jsonResponse = json.decode(response.body);

      final apiResponse = MyDataApiResponse<ForgotPasswordModel>.fromJson(
        jsonResponse,
            (data) => ForgotPasswordModel.fromJson(data),
      );

      if (apiResponse.isSuccess) {
        return DataApiResult.success(apiResponse.data, messages: apiResponse.messages);
      } else {
        return DataApiResult.error(apiResponse.messages);
      }
    } catch (e) {
      return DataApiResult.error(['Sistem Mesajı: $e']);
    }
  }
}