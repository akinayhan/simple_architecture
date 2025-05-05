import 'package:flutter/material.dart';
import '../../models/result/api_result.dart';

class CreateBaseViewModel<S, M> with ChangeNotifier {
  final S service;

  CreateBaseViewModel(this.service);

  Future<ApiResult> createOperation(M model, String token, Future<ApiResult> Function(M, String) operation) async {
    try {
      final response = await operation(model, token);
      return response;
    } catch (e) {
      return ApiResult.error([e.toString()]);
    }
  }
}
