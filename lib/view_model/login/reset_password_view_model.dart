import 'package:flutter/material.dart';
import '../../../../services/login/reset_password_service.dart';
import '../../models/login/reset_password_model..dart';
import '../../models/result/api_result.dart';

class ResetPasswordViewModel with ChangeNotifier {
  final ResetPasswordService _resetPasswordService;

  ResetPasswordViewModel() : _resetPasswordService = ResetPasswordService();

  Future<ApiResult> resetPassword(ResetPasswordModel resetPasswordModel) async {
    try {
      final response = await _resetPasswordService.resetPassword(resetPasswordModel);

      return response.success
          ? _handleSuccessResponse(response.messages)
          : _handleErrorResponse(response.messages);
    } catch (e) {
      return ApiResult.error([e.toString()]);
    }
  }

  ApiResult _handleSuccessResponse(dynamic messages) {
    List<String> parsedMessages = _parseMessages(messages);
    return ApiResult.success(parsedMessages);
  }

  ApiResult _handleErrorResponse(dynamic messages) {
    List<String> parsedMessages = _parseMessages(messages);
    return ApiResult.error(parsedMessages);
  }

  List<String> _parseMessages(dynamic messages) {
    return messages is List<String>
        ? List<String>.from(messages)
        : [messages.toString()];
  }
}