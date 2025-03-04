import '../../models/announcement/get_active_announcement_model.dart';
import '../../models/announcement/get_announcement_request_model.dart';
import '../../services/announcement/get_active_announcements_service.dart';
import '../base/get_base_view_model.dart';

class GetActiveAnnouncementsViewModel extends BaseViewModel<GetActiveAnnouncementModel> {
  Future<void> fetchActiveAnnouncements(String token, GetAnnouncementRequestModel requestModel) async {
    await fetchData(() => GetActiveAnnouncementsService().fetchActiveAnnouncements(token, requestModel));
  }
}