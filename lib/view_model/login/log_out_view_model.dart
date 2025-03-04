import 'package:flutter/material.dart';
import '../../utils/result/api_result.dart';
import '../../services/login/logout_service.dart';

class LogOutViewModel with ChangeNotifier {
  final LogOutService _logOutService;

  LogOutViewModel() : _logOutService = LogOutService();

  Future<ApiResult> logOut(String token) async {
    try {
      final response = await _logOutService.logOut(token);

      return response.success
          ? _handleResponse(response.messages, true)
          : _handleResponse(response.messages, false);
    } catch (e) {
      return ApiResult.error([e.toString()]);
    }
  }

  ApiResult _handleResponse(dynamic messages, bool isSuccess) {
    List<String> parsedMessages = _parseMessages(messages);
    return isSuccess
        ? ApiResult.success(parsedMessages)
        : ApiResult.error(parsedMessages);
  }

  List<String> _parseMessages(dynamic messages) {
    return messages is List<String>
        ? List<String>.from(messages)
        : [messages.toString()];
  }
}