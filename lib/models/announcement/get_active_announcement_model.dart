class GetActiveAnnouncementModel {
  int id;
  String title;
  String description;
  int visibilityRole;
  bool status;
  bool deleted;
  DateTime created;
  DateTime startDate;
  DateTime endDate;

  GetActiveAnnouncementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.visibilityRole,
    required this.status,
    required this.deleted,
    required this.created,
    required this.startDate,
    required this.endDate,
  });

  factory GetActiveAnnouncementModel.fromJson(Map<String, dynamic> json) {
    return GetActiveAnnouncementModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      visibilityRole: json['visibilityRole'] ?? 0,
      status: json['status'] ?? false,
      deleted: json['deleted'] ?? false,
      created: json['created'] != null ? DateTime.parse(json['created']) : DateTime.now(),
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : DateTime.now(),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : DateTime.now(),
    );
  }
}
