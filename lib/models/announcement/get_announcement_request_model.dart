class GetAnnouncementRequestModel {
  final int visibilityRole;
  final bool status;
  final bool deleted;

  GetAnnouncementRequestModel({
    required this.visibilityRole,
    required this.status,
    required this.deleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'visibilityRole': visibilityRole,
      'Status': status,
      'Deleted': deleted,
    };
  }
}