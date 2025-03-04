class StatusModel {
  bool status;
  String name;

  StatusModel({required this.status}) : name = status ? "Aktif" : "Pasif";
}

List<StatusModel> getStatusList() {
  return [
    StatusModel(status: true),
    StatusModel(status: false),
  ];
}