import 'package:flutter/foundation.dart';
import '../../models/other/get_leader_board_model.dart';
import '../../services/other/get_monthly_leaderboard_service.dart';
import '../../models/result/data_api_result.dart';
class GetMonthlyLeaderboardViewModel extends ChangeNotifier {
  DataApiResult<List<GetLeaderBoardModel>> _result = DataApiResult(success: false, messages: []);
  DataApiResult<List<GetLeaderBoardModel>> get result => _result;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<GetLeaderBoardModel> _listLeaderBoard  = [];
  List<GetLeaderBoardModel> get listLeaderBoard => _listLeaderBoard ;

  Future<void> fetchMonthlyLeaderboard(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _result = await GetMonthlyLeaderboardService.fetchMonthlyLeaderboard(token);
      _listLeaderBoard = _result.data ?? [];
    } catch (e) {
      _result = DataApiResult.error(['Bir hata oluştu: $e']);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}