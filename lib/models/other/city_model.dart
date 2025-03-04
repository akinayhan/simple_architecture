class CityModel {
  int id;
  String name;

  CityModel({
    required this.id,
    required this.name
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
