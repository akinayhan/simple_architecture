class SingleDataApiResponse<T> {
  final bool isSuccess;
  final List<String> messages;
  final T? data;

  SingleDataApiResponse({
    required this.isSuccess,
    required this.messages,
    this.data,
  });

  factory SingleDataApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonFunction,
      ) {
    return SingleDataApiResponse(
      isSuccess: json['isSuccess'] ?? false,
      messages: List<String>.from(json['messages'] ?? []),
      data: json['data'] != null ? fromJsonFunction(json['data']) : null,
    );
  }
}
