class VehicleCategoriesModel {
  int? id;
  String name;

  VehicleCategoriesModel({
    this.id,
    required this.name,
  });

  factory VehicleCategoriesModel.fromJson(Map<String, dynamic> json) {
    return VehicleCategoriesModel(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}