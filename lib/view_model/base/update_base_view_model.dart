import 'package:flutter/material.dart';
import '../../../utils/result/api_result.dart';

class UpdateBaseViewModel<S, M> with ChangeNotifier {
  final S service;

  UpdateBaseViewModel(this.service);

  Future<ApiResult> updateOperation(M model, String token, Future<ApiResult> Function(M, String) operation) async {
    try {
      final response = await operation(model, token);
      return response;
    } catch (e) {
      return ApiResult.error([e.toString()]);
    }
  }
}
