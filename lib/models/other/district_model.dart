class DistrictModel {
  int id;
  int cityId;
  String name;

  DistrictModel({
    required this.id,
    required this.cityId,
    required this.name});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'] as int,
      cityId: json['cityId'] as int,
      name: json['name'] as String,
    );
  }
}
