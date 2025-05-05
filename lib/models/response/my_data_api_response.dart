class MyDataApiResponse<T> {
  final bool isSuccess;
  final List<String> messages;
  final T? data;

  MyDataApiResponse({
    required this.isSuccess,
    required this.messages,
    this.data,
  });

  factory MyDataApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonFunction) {
    return MyDataApiResponse(
      isSuccess: json['isSuccess'] ?? false,
      messages: List<String>.from(json['messages'] ?? []),
      data: json['data'] != null ? fromJsonFunction(json['data']) : null,
    );
  }
}
