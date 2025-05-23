import 'package:flutter/material.dart';
import '../../../models/login/sign_up_model.dart';
import '../../../services/login/sign_up_service.dart';
import '../../models/result/api_result.dart';

class SignUpViewModel with ChangeNotifier {
  final SignUpService _signUpService;

  SignUpViewModel() : _signUpService = SignUpService();

  Future<ApiResult> signUpOperation(SignUpModel signUpModel) async {
    try {
      final response = await _signUpService.signUpOperation(signUpModel);

      return response;
    } catch (e) {
      return ApiResult.error([e.toString()]);
    }
  }
}