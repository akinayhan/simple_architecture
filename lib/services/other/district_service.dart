import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/other/district_model.dart';
import '../../utils/response/data_api_response.dart';
import '../../utils/result/data_api_result.dart';
import '../../utils/constants/api_constants.dart';

class DistrictService {
  static const String baseUrl = ApiConstants.apiUrl;

  static Future<DataApiResult<List<DistrictModel>>> fetchAllDistricts(int cityId) async {
    try {
      final url = Uri.parse('$baseUrl/General/GetDistrictsByCity?cityId=$cityId');
      final response = await http.get(url);

      String responseBody = response.body;

      try {
        DataApiResponse<DistrictModel> jsonResponse = DataApiResponse.fromJson(
          jsonDecode(responseBody),
              (data) => DistrictModel.fromJson(data),
        );

        if (!jsonResponse.isSuccess) {
          return DataApiResult.error(jsonResponse.messages);
        }
        return DataApiResult.success(jsonResponse.items);
      } catch (e) {
        return DataApiResult.error(['Veri işlenirken bir hata oluştu.']);
      }
    } catch (e) {
      return DataApiResult.error(['İnternet bağlantınızı kontrol edin.']);
    }
  }
}