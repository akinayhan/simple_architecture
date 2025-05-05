class ApiResult {
  final bool success;
  final List<String> messages;

  ApiResult({required this.success, required this.messages});

  factory ApiResult.success(List<String> messages) {
    return ApiResult(success: true, messages: messages);
  }

  factory ApiResult.error(List<String> messages) {
    return ApiResult(success: false, messages: messages);
  }
}
