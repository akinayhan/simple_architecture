import 'package:flutter/material.dart';
import '../../../../models/login/forgot_password_model.dart';
import '../../../../services/login/forgot_password_service.dart';
import '../../../../utils/result/data_api_result.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = '';
  String get message => _message;

  ForgotPasswordModel? _forgotPasswordData;
  ForgotPasswordModel? get forgotPasswordData => _forgotPasswordData;

  String _email = '';
  String get email => _email;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  Future<DataApiResult<ForgotPasswordModel?>> sendPasswordResetRequest(String email) async {
    try {
      _isLoading = true;
      setMessage('');
      DataApiResult<ForgotPasswordModel?> result = await ForgotPasswordService.sendPasswordResetRequest(email);
      if (result.success) {
        _forgotPasswordData = result.data;
        setMessage(result.messages.isNotEmpty ? result.messages[0] : 'İşlem başarıyla gerçekleştirildi.');
      } else {
        setMessage(result.messages.isNotEmpty ? result.messages[0] : 'Bir hata oluştu.');
      }
      return result;
    } catch (e) {
      setMessage('Beklenmeyen bir hata oluştu.');
      return DataApiResult(
        success: false,
        messages: ['Beklenmeyen bir hata oluştu.'],
        data: null,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
