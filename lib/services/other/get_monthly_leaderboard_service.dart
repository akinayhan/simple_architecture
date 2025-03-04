import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/other/get_leader_board_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/navigate/navigate_to_login.dart';
import '../../utils/response/data_api_response.dart';
import '../../utils/result/data_api_result.dart';

class GetMonthlyLeaderboardService {
  static const String baseUrl = ApiConstants.apiUrl;

  static Future<DataApiResult<List<GetLeaderBoardModel>>> fetchMonthlyLeaderboard(String token) async {
    try {

      final url = Uri.parse('$baseUrl/General/GetMonthlyLeaderboard');
      final response = await http.get(url,
        headers: {'Authorization': 'Bearer $token'},
      );

      String responseBody = response.body;

      try {
        DataApiResponse<GetLeaderBoardModel> jsonResponse = DataApiResponse.fromJson(
          jsonDecode(responseBody),
              (data) => GetLeaderBoardModel.fromJson(data),
        );

        if (response.statusCode == 401) {
          navigateToLoginPage();
          return DataApiResult<List<GetLeaderBoardModel>>.error(jsonResponse.messages);
        }

        if (!jsonResponse.isSuccess) {
          if (jsonResponse.messages.isEmpty) {
            navigateToLoginPage();
          }
          return DataApiResult<List<GetLeaderBoardModel>>.error(jsonResponse.messages);
        }
        return DataApiResult<List<GetLeaderBoardModel>>.success(jsonResponse.items);
      } catch (e) {
        navigateToLoginPage();
        return DataApiResult<List<GetLeaderBoardModel>>.error(['Oturumunuz süreniz sona ermiştir.']);
      }
    } catch (e) {
      if (e is DataApiResult && e.messages.isEmpty) {
        navigateToLoginPage();
      }
      return DataApiResult<List<GetLeaderBoardModel>>.error(['İnternet bağlantınızı kontrol edin']);
    }
  }
}