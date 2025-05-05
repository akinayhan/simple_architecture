import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/constants/api_constants.dart';
import '../../models/login/login_response_model.dart';
import '../../models/login/sign_in_model.dart';
import '../../models/response/single_data_api_response.dart';
import '../../models/result/data_api_result.dart';

class SignInService {
  static const String baseUrl = ApiConstants.apiUrl;

  static Future<DataApiResult<LoginResponseModel>> getLoginResponse(SignInModel signInModel) async {
    final url = Uri.parse('$baseUrl/Account/Login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(signInModel.toJson()),
      );

      final responseBody = jsonDecode(response.body);


      if (response.statusCode == 200) {
        final jsonResponse = SingleDataApiResponse<LoginResponseModel>.fromJson(
          responseBody,
              (data) => LoginResponseModel.fromJson(data),
        );

        if (jsonResponse.isSuccess) {
          return DataApiResult.success(jsonResponse.data);
        } else {
          return DataApiResult.error(jsonResponse.messages);
        }
      } else {
        final jsonResponse = SingleDataApiResponse<LoginResponseModel>.fromJson(
          responseBody,
              (data) => LoginResponseModel.fromJson(data),
        );

        return DataApiResult.error(jsonResponse.messages.isNotEmpty
            ? jsonResponse.messages
            : ['Sunucu hatası: ${response.statusCode}']);
      }
    } catch (e) {
      return DataApiResult.error(['İnternet bağlantınızı kontrol edin']);
    }
  }
}