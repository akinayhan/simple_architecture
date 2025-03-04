import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/response/data_api_response.dart';
import '../../../utils/result/data_api_result.dart';
import '../../models/other/city_model.dart';
import '../../utils/constants/api_constants.dart';

class CityService {
  static const String baseUrl = ApiConstants.apiUrl;

  static Future<DataApiResult<List<CityModel>>> fetchCities() async {
    try {
      final url = Uri.parse('$baseUrl/General/GetCities');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      String responseBody = response.body;
      try {
        DataApiResponse<CityModel> jsonResponse = DataApiResponse.fromJson(
          jsonDecode(responseBody),
              (data) => CityModel.fromJson(data),
        );
        if (!jsonResponse.isSuccess) {
          return DataApiResult<List<CityModel>>.error(jsonResponse.messages);
        }
        return DataApiResult<List<CityModel>>.success(jsonResponse.items);
      } catch (e) {
        return DataApiResult<List<CityModel>>.error(['Veri işlenirken bir hata oluştu.']);
      }
    } catch (e) {
      return DataApiResult<List<CityModel>>.error(['İnternet bağlantınızı kontrol edin.']);
    }
  }
}