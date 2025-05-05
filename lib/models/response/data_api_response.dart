class DataApiResponse<T> {
  final bool isSuccess;
  final List<String> messages;
  final List<T> items;

  DataApiResponse({required this.isSuccess, required this.messages, required this.items});

  factory DataApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonFunction) {
    return DataApiResponse(
      isSuccess: json['isSuccess'] ?? false,
      messages: List<String>.from(json['messages'] ?? []),
      items: (json['data'] != null)
          ? List<T>.from(json['data'].map((data) => fromJsonFunction(data)))
          : [],
    );
  }
}
