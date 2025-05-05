class DataApiResult<T> {
  final bool success;
  final List<String> messages;
  final T? data;

  DataApiResult({required this.success, required this.messages, this.data});

  factory DataApiResult.success(T? data, {List<String>? messages}) {
    return DataApiResult(success: true, data: data, messages: messages ?? []);
  }

  factory DataApiResult.error(List<String> messages) {
    return DataApiResult(success: false, messages: messages);
  }
}