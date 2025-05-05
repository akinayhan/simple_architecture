class ApiResponse {
  final bool isSuccess;
  final List<String> messages;

  ApiResponse({required this.isSuccess, required this.messages});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      isSuccess: json['isSuccess'] ?? false,
      messages: List<String>.from(json['messages'] ?? []),
    );
  }
}
