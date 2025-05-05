import 'package:flutter/material.dart';
import '../../../../models/announcement/filter_announcement_role_model.dart';

List<DropdownMenuItem<int>> buildAnnouncementRoleDropdownItems(List<FilterAnnouncementRoleModel> filterAnnouncementRoleModel) {
  return filterAnnouncementRoleModel.map((filterAnnouncementRoleModel) {
    return DropdownMenuItem<int>(
      value: filterAnnouncementRoleModel.type,
      child: Text(filterAnnouncementRoleModel.name),
    );
  }).toList();
}


