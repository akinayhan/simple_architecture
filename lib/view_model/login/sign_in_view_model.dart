import 'package:flutter/material.dart';
import '../../models/login/sign_in_model.dart';
import '../../services/login/sign_in_service.dart';
import '../../utils/result/data_api_result.dart';
import '../../models/login/login_response_model.dart';

class SignInViewModel extends ChangeNotifier {
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<DataApiResult<LoginResponseModel>> signInWithUserAndPassword(SignInModel signInModel) async {
    final result = await SignInService.getLoginResponse(signInModel);

    if (result.success) {
      _errorMessage = '';
    } else {
      _errorMessage = result.messages.isNotEmpty ? result.messages.join(', ') : 'Bir hata oluştu.';
    }

    notifyListeners();
    return result;
  }
}
