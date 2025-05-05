import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/other/get_app_version_control_model.dart';
import '../../models/response/data_api_response.dart';
import '../../models/result/data_api_result.dart';
import '../../utils/constants/api_constants.dart';

class GetAppVersionControlService {
  static const String baseUrl = ApiConstants.apiUrl;

  static Future<DataApiResult<List<GetAppVersionControlModel>>> fetchAppVersionControl() async {
    try {
      final url = Uri.parse('$baseUrl/General/GetAppVersionControl');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      String responseBody = response.body;
      try {
        DataApiResponse<GetAppVersionControlModel> jsonResponse = DataApiResponse.fromJson(
          jsonDecode(responseBody),
              (data) => GetAppVersionControlModel.fromJson(data),
        );
        if (!jsonResponse.isSuccess) {
          return DataApiResult<List<GetAppVersionControlModel>>.error(jsonResponse.messages);
        }
        return DataApiResult<List<GetAppVersionControlModel>>.success(jsonResponse.items);
      } catch (e) {
        return DataApiResult<List<GetAppVersionControlModel>>.error(['Veri işlenirken bir hata oluştu.']);
      }
    } catch (e) {
      return DataApiResult<List<GetAppVersionControlModel>>.error(['İnternet bağlantınızı kontrol edin.']);
    }
  }
}