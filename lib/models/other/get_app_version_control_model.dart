class GetAppVersionControlModel {
  int id;
  String androidVersion;
  int androidVersionCode;
  String androidVersionUrl;
  String androidMessage;
  String iosVersion;
  int iosVersionCode;
  String iosVersionUrl;
  String iosMessage;
  String webVersion;
  int webVersionCode;
  String webVersionUrl;
  String webMessage;
  DateTime releaseDate;

  GetAppVersionControlModel({
    required this.id,
    required this.androidVersion,
    required this.androidVersionCode,
    required this.androidVersionUrl,
    required this.androidMessage,
    required this.iosVersion,
    required this.iosVersionCode,
    required this.iosVersionUrl,
    required this.iosMessage,
    required this.webVersion,
    required this.webVersionCode,
    required this.webVersionUrl,
    required this.webMessage,
    required this.releaseDate,
  });

  factory GetAppVersionControlModel.fromJson(Map<String, dynamic> json) {
    return GetAppVersionControlModel(
      id: json['Id'] as int? ?? 0,
      androidVersion: json['AndroidVersion'] as String? ?? '',
      androidVersionCode: json['AndroidVersionCode'] as int? ?? 0,
      androidVersionUrl: json['AndroidVersionUrl'] as String? ?? '',
      androidMessage: json['AndroidMessage'] as String? ?? '',
      iosVersion: json['IosVersion'] as String? ?? '',
      iosVersionCode: json['IosVersionCode'] as int? ?? 0,
      iosVersionUrl: json['IosVersionUrl'] as String? ?? '',
      iosMessage: json['IosMessage'] as String? ?? '',
      webVersion: json['WebVersion'] as String? ?? '',
      webVersionCode: json['WebVersionCode'] as int? ?? 0,
      webVersionUrl: json['WebVersionUrl'] as String? ?? '',
      webMessage: json['WebMessage'] as String? ?? '',
      releaseDate: DateTime.tryParse(json['ReleaseDate'] ?? '') ?? DateTime(2000, 1, 1),
    );
  }
}